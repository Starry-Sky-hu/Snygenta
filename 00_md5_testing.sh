path=/vol3/agis/huangsanwen_group/huyong/Snygenta/raw/2.cleandata
species=($(cat /public/agis/huangsanwen_group/huyong/Sny/raw_data/directory.txt))
i_max=${#species[@]}
let i_max=i_max-1
for i in $(seq 0 ${i_max})
do
        cd ${path}/${species[i]}
        md5sum -c *.txt >> /public/agis/huangsanwen_group/huyong/Sny/result_data/md5_check.txt
done