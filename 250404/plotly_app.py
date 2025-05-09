# 파일명 : plotly_app.py
# 라이브러리 불러오기
import plotly.express as px
import plotly.graph_objects as go
import pandas as pd
import streamlit as st
import seaborn as sns

st.title("Plotly 튜토리얼")

# tips 데이터셋 불러오기
tips = sns.load_dataset('tips')

# 데이터 미리보기
st.subheader('데이터 미리보기')
st.dataframe(tips.head())

# 기본 막대 그래프
st.subheader("1. 기본 막대 그래프")
fig = px.bar(tips,
              x = 'day', 
              y = 'tip', 
              title= '요일별 지불 금액', 
              labels = {'day' : '요일', 'tip' : '평균 Tip($)'})
st.plotly_chart(fig, use_container_width =True)

# 산점도
st.subheader("2. 산점도")
# plotly Express scatter plot 생성


fig1 = px.scatter(tips,
                  x = 'total_bill',
                  y = 'tip')
st.plotly_chart(fig1)



