../prepare-image.sh -c step1.png "470,502 820,600"
../prepare-image.sh -c step2.png "355,890 700,1030"
../prepare-image.sh -c step3.png "440,1740 2100,2095"
../prepare-image.sh -c step4.png "1300,900 1700,1000"
../prepare-image.sh -c step5.png
../prepare-image.sh -c test-case-results.png "440,1740 2100,1835" "440,1910 2100,2005"
cp test-case-results.png test-case-details.png
../prepare-image.sh -c test-case-details.png "2150,1740 2350,1835"
../prepare-image.sh -c manual-comment.png
../prepare-image.sh -c manual-comment-overview.png
mogrify -format jpg meme.png
../prepare-image.sh -c test-case-shell.png