ref=/vol3/agis/huangsanwen_group/huyong/Snygenta/ref/S_lycopersicum_chromosomes.4.00.fa
resultPath=/vol3/agis/huangsanwen_group/huyong/Snygenta/tem_file



gatk CombineGVCFs -R ${ref} \
                  -V gvcf_path \
                  -O ${resultPath}/cohort.g.vcf.gz


gatk GenotypeGVCFs -R ${ref} \
                    -V ${resultPath}/cohort.g.vcf.gz \
                    -O ${resultPath}/output.vcf.gz


gatk SelectVariants -R ${ref} \
                    -V ${resultPath}/output.vcf.gz \
                    --select-type-to-include SNP \
                    -O ${resultPath}/SNPoutput.vcf.gz


gatk VariantsToTable -R ${ref} \
                      -V ${resultPath}/SNPoutput.vcf.gz \
                      -F CHROM -F POS -F REF -F ALT -GF GT
                      -O ${resultPath}/SNPoutput.table