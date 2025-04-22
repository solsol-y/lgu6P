read -p "Enter the commit message: " commit_message
timestamp=$(date +"%Y-%m-%d %H:%M")
branch=$(git rev-parse --abbrev-ref HEAD)
현재 브랜치 확인
if [ -z "$branch" ]; then
  echo "❌ 현재 브랜치를 확인할 수 없습니다. git 저장소가 아닐 수 있습니다."
  exit 1
fi
echo "🔄 현재 브랜치: $branch  "
변경사항 보여주기
echo "🔍 변경된 파일들:"
git status -s
echo ""

커밋 메시지 입력 받기
read -p "📝 커밋 메시지를 입력하세요 (비우면 기본 메시지 사용): " msg

기본 메시지 설정
if [ -z "$msg" ]; then
  msg="자동 커밋"
fi

최종 메시지 구성
commit_msg="🚀 [$branch] $timestamp - $msg"

git 명령어 실행
git add .
git commit -m "$commit_msg"
git push

echo "✅ 푸시 완료: $commit_msg"read -p "Enter the commit message: " commit_message
timestamp=$(date +"%Y-%m-%d %H:%M")
branch=$(git rev-parse --abbrev-ref HEAD)
현재 브랜치 확인
if [ -z "$branch" ]; then
  echo "❌ 현재 브랜치를 확인할 수 없습니다. git 저장소가 아닐 수 있습니다."
  exit 1
fi
echo "🔄 현재 브랜치: $branch  "
변경사항 보여주기
echo "🔍 변경된 파일들:"
git status -s
echo ""

커밋 메시지 입력 받기
read -p "📝 커밋 메시지를 입력하세요 (비우면 기본 메시지 사용): " msg

기본 메시지 설정
if [ -z "$msg" ]; then
  msg="자동 커밋"
fi

최종 메시지 구성
commit_msg="🚀 [$branch] $timestamp - $msg"

git 명령어 실행
git add .
git commit -m "$commit_msg"
git push

echo "✅ 푸시 완료: $commit_msg"