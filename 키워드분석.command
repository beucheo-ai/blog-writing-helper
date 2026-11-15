#!/bin/zsh
# 더블클릭 실행: 키워드를 입력하면 후보 비교표를 보여 줘요.
# .env가 없으면 예시 데이터(데모)로 실행해요.
cd "$(dirname "$0")"

if [ ! -f .env ]; then
  echo "ℹ️  .env 파일이 없어요. 예시 데이터(데모)로 실행합니다."
  echo "   실제로 쓰려면 README.md의 'API 키 준비'를 따라 .env를 만들어 주세요."
  echo ""
  python3 도구/seo_analyze.py --demo
else
  echo "비교할 키워드를 입력하세요 (여러 개는 쉼표로 구분):"
  read input
  IFS=',' read -rA kws <<< "$input"
  args=()
  for k in "${kws[@]}"; do
    k="${k## }"; k="${k%% }"
    [ -n "$k" ] && args+=("$k")
  done
  python3 도구/seo_analyze.py --quick "${args[@]}"
fi

open reports 2>/dev/null
echo ""
echo "엔터를 누르면 창이 닫힙니다."
read
