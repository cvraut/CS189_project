conda activate cg_yeast

BlockDisplaySatsuma -i outputs/g833-1B_reference/satsuma_summary.chained.out -t data/S288C_reference.fasta -q data/g833-1B_reference.fasta > S288C_v_g833.out
ChromosomePaint -d 10 -s 400 -i S288C_v_g833.out -o S288C_v_g833.ps
BlockDisplaySatsuma -i outputs/SK1_reference/satsuma_summary.chained.out -t data/S288C_reference.fasta -q data/SK1_reference.fasta > S288C_v_SK1.out
ChromosomePaint -d 10 -s 400 -i S288C_v_SK1.out -o S288C_v_SK1.ps
BlockDisplaySatsuma -i outputs/suvarum_cbs7001/satsuma_summary.chained.out -t data/S288C_reference.fasta -q data/suvarum_cbs7001.fasta > S288C_v_cbs7001.out
ChromosomePaint -d 10 -s 400 -i S288C_v_cbs7001.out -o S288C_v_cbs7001.ps
BlockDisplaySatsuma -i outputs/W303_reference/satsuma_summary.chained.out -t data/S288C_reference.fasta -q data/W303_reference.fasta > S288C_v_W303.out
ChromosomePaint -d 10 -s 400 -i S288C_v_W303.out -o S288C_v_W303.ps

conda deactivate
