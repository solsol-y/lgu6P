# 필요한 라이브러리 임포트
import torch  # PyTorch 딥러닝 프레임워크
import torch.nn as nn  # 신경망 모듈
import torch.optim as optim  # 최적화 알고리즘
from sklearn.preprocessing import LabelEncoder, StandardScaler  # 데이터 전처리 도구
from sklearn.model_selection import train_test_split  # 데이터 분할
import pandas as pd  # 데이터 처리
import matplotlib.pyplot as plt

def mapk(actual, predicted, k=3):
    """
    actual: (N,) numpy array, 정답 인덱스
    predicted: (N, k) numpy array, 각 row별로 상위 k개 예측 인덱스
    """
    score = 0.0
    for a, p in zip(actual, predicted):
        try:
            idx = list(p).index(a)
            score += 1.0 / (idx + 1)
        except ValueError:
            continue
    return score / len(actual)

# 학습 데이터 로드
df = pd.read_csv("train.csv")

# 범주형 변수 인코딩을 위한 LabelEncoder 객체 생성
le_soil = LabelEncoder()  # 토양 타입 인코더
le_crop = LabelEncoder()  # 작물 타입 인코더
le_target = LabelEncoder()  # 비료 이름 인코더

# 범주형 변수들을 숫자로 변환
df['Soil Type'] = le_soil.fit_transform(df['Soil Type'])  # 토양 타입을 숫자로 변환
df['Crop Type'] = le_crop.fit_transform(df['Crop Type'])  # 작물 타입을 숫자로 변환
df['Fertilizer Name'] = le_target.fit_transform(df['Fertilizer Name'])  # 비료 이름을 숫자로 변환

# 입력 특성과 타겟 변수 분리
features = df.drop(columns=['id', 'Fertilizer Name'])  # id와 타겟 변수 제외한 특성
target = df['Fertilizer Name']  # 타겟 변수

# 특성 스케일링 (정규화)
scaler = StandardScaler()  # 표준화 스케일러 생성
features_scaled = scaler.fit_transform(features)  # 특성 정규화

# 학습/검증 데이터 분할 (80:20)
X_train, X_test, y_train, y_test = train_test_split(features_scaled, target, test_size=0.2, random_state=42)

# GPU 사용 가능 여부에 따라 device 설정
device = torch.device('cuda' if torch.cuda.is_available() else 'cpu')

# 데이터를 PyTorch 텐서로 변환하고 device로 이동
X_train_tensor = torch.tensor(X_train, dtype=torch.float32).to(device)  # 학습 데이터
y_train_tensor = torch.tensor(y_train.values, dtype=torch.long).to(device)  # 학습 타겟
X_test_tensor = torch.tensor(X_test, dtype=torch.float32).to(device)  # 검증 데이터
y_test_tensor = torch.tensor(y_test.values, dtype=torch.long).to(device)  # 검증 타겟

# 신경망 모델 정의
class FertilizerNet(nn.Module):
    def __init__(self, input_dim, output_dim):
        super(FertilizerNet, self).__init__()
        self.fc1 = nn.Linear(input_dim, 32)  # 첫 번째 완전연결층
        self.relu = nn.ReLU()  # ReLU 활성화 함수
        self.fc2 = nn.Linear(32, 16)  # 두 번째 완전연결층
        self.out = nn.Linear(16, output_dim)  # 출력층
    
    def forward(self, x):
        x = self.relu(self.fc1(x))  # 첫 번째 층 통과
        x = self.relu(self.fc2(x))  # 두 번째 층 통과
        x = self.out(x)  # 출력층 통과
        return x

# 모델 초기화
input_dim = X_train_tensor.shape[1]  # 입력 특성의 차원
output_dim = len(le_target.classes_)  # 출력 클래스의 수
model = FertilizerNet(input_dim, output_dim).to(device)  # 모델 생성 및 device로 이동

# 손실 함수와 최적화 알고리즘 설정
criterion = nn.CrossEntropyLoss()  # 교차 엔트로피 손실 함수
optimizer = optim.Adam(model.parameters(), lr=0.01)  # Adam 최적화 알고리즘

# 모델 학습
epochs = 100  # 전체 학습 횟수
train_losses = []
val_losses = []
train_maps = []
val_maps = []

for epoch in range(epochs):
    model.train()  # 학습 모드
    outputs = model(X_train_tensor)  # 순전파
    loss = criterion(outputs, y_train_tensor)  # 손실 계산
    optimizer.zero_grad()  # 그래디언트 초기화
    loss.backward()  # 역전파
    optimizer.step()  # 파라미터 업데이트
    train_losses.append(loss.item())

    # train MAP@3
    with torch.no_grad():
        train_probs = torch.softmax(outputs, dim=1)
        # 각 샘플에 대해 상위 3개 클래스의 인덱스를 추출하고 CPU로 이동한 후 NumPy 배열로 변환
        train_top3 = torch.topk(train_probs, k=3, dim=1).indices.cpu().numpy()
        train_map = mapk(y_train_tensor.cpu().numpy(), train_top3, k=3)
        train_maps.append(train_map)

    # validation
    model.eval()
    with torch.no_grad():
        val_outputs = model(X_test_tensor)
        val_loss = criterion(val_outputs, y_test_tensor)
        val_losses.append(val_loss.item())
        val_probs = torch.softmax(val_outputs, dim=1)
        val_top3 = torch.topk(val_probs, 3, dim=1).indices.cpu().numpy()
        val_map = mapk(y_test_tensor.cpu().numpy(), val_top3, k=3)
        val_maps.append(val_map)

    if (epoch + 1) % 10 == 0:
        print(f"Epoch [{epoch+1}/{epochs}], Loss: {loss.item():.4f}, Val Loss: {val_loss.item():.4f}, Train MAP@3: {train_map:.4f}, Val MAP@3: {val_map:.4f}")

# 모델 평가
model.eval()  # 평가 모드
with torch.no_grad():  # 그래디언트 계산 비활성화
    test_outputs = model(X_test_tensor)  # 테스트 데이터 예측
    _, predicted = torch.max(test_outputs, 1)  # 가장 높은 확률의 클래스 선택
    accuracy = (predicted == y_test_tensor).float().mean().item()  # 정확도 계산

# 테스트 데이터 전처리
test_df = pd.read_csv("test.csv")  # 테스트 데이터 로드
test_df['Soil Type'] = le_soil.transform(test_df['Soil Type'])  # 토양 타입 변환
test_df['Crop Type'] = le_crop.transform(test_df['Crop Type'])  # 작물 타입 변환
test_features = test_df.drop(columns=['id'])  # id 제외
test_features_scaled = scaler.transform(test_features)  # 특성 정규화
X_test_final = torch.tensor(test_features_scaled, dtype=torch.float32).to(device)  # 텐서 변환

# 최종 예측
model.eval()
with torch.no_grad():
    outputs = model(X_test_final)  # 예측
    probs = torch.softmax(outputs, dim=1)  # 확률로 변환
    top3 = torch.topk(probs, 3, dim=1).indices.cpu().numpy()  # 상위 3개 클래스 선택

# 예측 결과를 원래 레이블로 변환
top3_labels = le_target.inverse_transform(top3.flatten()).reshape(top3.shape)

# 제출 파일 생성
submission = pd.DataFrame({
    'id': test_df['id'],
    'Fertilizer Name': [' '.join(row) for row in top3_labels]  # 각 행의 예측값을 공백으로 구분하여 결합
})
submission.to_csv('submission.csv', index=False)  # CSV 파일로 저장
print("submission.csv 파일이 생성되었습니다.")

# 1x2 subplot 시각화
fig, axes = plt.subplots(1, 2, figsize=(14, 5))
# 왼쪽: 손실 곡선
axes[0].plot(train_losses, label='Train Loss', color='tab:blue')
axes[0].plot(val_losses, label='Validation Loss', color='tab:orange')
axes[0].set_xlabel('Epoch')
axes[0].set_ylabel('Loss')
axes[0].set_title('Loss Curve')
axes[0].legend()
# 오른쪽: MAP@3 곡선
axes[1].plot(train_maps, label='Train MAP@3', color='tab:green')
axes[1].plot(val_maps, label='Validation MAP@3', color='tab:red')
axes[1].set_xlabel('Epoch')
axes[1].set_ylabel('MAP@3')
axes[1].set_title('MAP@3 Curve')
axes[1].legend()
plt.tight_layout()
plt.savefig('loss_map_curve_1x2.png')
plt.show()
