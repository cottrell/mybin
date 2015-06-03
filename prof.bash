for x in $*; do
    b=$(basename $x).pdf
    echo "$x -> $b"
    gprof2dot -f pstats $x | dot -Tpdf -o $b
    # gprof2dot -f pstats $x > $b.dot
    # dot -Tpdf -o $b.pdf
done
