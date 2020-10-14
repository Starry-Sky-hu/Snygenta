ref=/vol3/agis/huangsanwen_group/huyong/Snygenta/ref/S_lycopersicum_chromosomes.4.00.fa
path=/vol3/agis/huangsanwen_group/huyong/Snygenta/raw/2.cleandata
resultPath=/vol3/agis/huangsanwen_group/huyong/Snygenta/tem_file
species=($(cat /public/agis/huangsanwen_group/huyong/Sny/raw_data/directory.txt))

i_max=${#species[@]}
let i_max=i_max-1

for i in $(seq 0 ${i_max})
do

        echo -e "cd ${path}/${species[i]}\n" > ${species[i]:14:6}.sh

        echo "bwa mem -R \"@RG\tID:${species[i]}\tSM:${species[i]}\tPL:illumina\" ${ref} ${species[i]}_1* ${species[i]}_2* > ${resultPath}/${species[i]}_aligned_reads.sam" >> ${species[i]:14:6}.sh
        echo "  " >> ${species[i]:14:6}.sh

        echo -e "samtools sort ${resultPath}/${species[i]}_aligned_reads.sam -o ${resultPath}/${species[i]}_sort.bam\n" >> ${species[i]:14:6}.sh

        echo -e "samtools rmdup ${resultPath}/${species[i]}_sort.bam ${resultPath}/${species[i]}_sort_rmduped.bam\n" >> ${species[i]:14:6}.sh

        echo -e "samtools index ${resultPath}/${species[i]}_sort_rmduped.bam\n" >> ${species[i]:14:6}.sh

        echo -e "gatk HaplotypeCaller -R ${ref} -I ${resultPath}/${species[i]}_sort_rmduped.bam -O ${resultPath}/${species[i]}.g.vcf.gz -ERC GVCF\n" >> ${species[i]:14:6}.sh

        echo -e "rm ${resultPath}/${species[i]}_aligned_reads.sam ${resultPath}/${species[i]}_sort.bam ${resultPath}/${species[i]}_sort_rmduped.bam\n" >> ${species[i]:14:6}.sh
done
