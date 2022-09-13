set -euxo pipefail

# pdflatex --shell-escape example1.tex
# pdflatex --shell-escape example2.tex
# pdflatex --shell-escape example3.tex
# pdflatex --shell-escape example4.tex
# pdflatex --shell-escape step11.tex
# pdflatex --shell-escape step12.tex
# pdflatex --shell-escape step21.tex
# pdflatex --shell-escape step22.tex
# pdflatex --shell-escape step3.tex
# pdflatex --shell-escape sllist.tex
# pdflatex --shell-escape sllist-add1.tex
# pdflatex --shell-escape sllist-add2.tex
# pdflatex --shell-escape dllist.tex
# pdflatex --shell-escape dllist-add1.tex
# pdflatex --shell-escape dllist-add2.tex
# pdflatex --shell-escape dllist-add3.tex
# pdflatex --shell-escape dllist-add4.tex
# pdflatex --shell-escape o-notation.tex

./mksvg.sh constant-factor.tex
./mksvg.sh linear-function.tex
./mksvg.sh quadratic-function.tex