#!/bin/sh
#
# Copyright (C) 2020 luci-app-jd-dailybonus <jerrykuku@qq.com>
#
# This is free software, licensed under the GNU General Public License v3.
# See /LICENSE for more information.
#
version="1.7"
cron_file=/etc/crontabs/root
url=https://raw.githubusercontent.com/lxk0301/jd_scripts/master
dir_file=/usr/share/JD_Script
dir_file_js=/usr/share/JD_Script/js
node=/usr/bin/node
red="\033[31m"
green="\033[32m"
yellow="\033[33m"
white="\033[0m"

start_script="脚本开始运行，当前时间：`date "+%Y-%m-%d %H:%M"`"
stop_script="脚本结束，当前时间：`date "+%Y-%m-%d %H:%M"`"

#计划任务
new_task1="###########这里是JD_Script的定时任务2.27版本###########"
new_task2="1 0 * * * /usr/share/JD_Script/jd.sh run_0  >/tmp/jd_run_0.log 2>&1" #0点1分执行全部脚本
new_task3="*/30 2-23 * * * /usr/share/JD_Script/jd.sh run_030 >/tmp/jd_run_030.log 2>&1" #1点-23点每30分钟执行一次run_030
new_task4="0 7-23 * * * /usr/share/JD_Script/jd.sh run_01 >/tmp/jd_run_01.log 2>&1" #一个小时第0分运行一次run_01
new_task5="2 2-22/2 * * * /usr/share/JD_Script/jd.sh run_02 >/tmp/jd_run_02.log 2>&1" #每两个小时执行一次run_02
new_task6="10 2-22/3 * * * /usr/share/JD_Script/jd.sh run_03 >/tmp/jd_run_03.log 2>&1" #每三个小时执行一次run_03
new_task7="1 6-18/6 * * * /usr/share/JD_Script/jd.sh run_06_18 >/tmp/jd_run_06_18.log 2>&1" #6点 12点18点执行一次run_06_18
new_task8="5 10,15,20 * * * /usr/share/JD_Script/jd.sh run_10_15_20 >/tmp/jd_run_10_15_20.log 2>&1"  #10点,15点,20点执行一次run_10_15_20
new_task9="10 8,12,16 * * * /usr/share/JD_Script/jd.sh run_08_12_16 >/tmp/jd_run_08_12_16.log 2>&1" #8点，12点，16点的第10分钟执行一次
new_task10="00 22 * * * /usr/share/JD_Script/jd.sh update_script >/tmp/jd_update_script.log 2>&1" #22点更新JD_Script脚本
new_task11="30 22 * * * /usr/share/JD_Script/jd.sh update >/tmp/jd_update.log 2>&1" #22点30分更新lxk0301脚本
new_task12="1 9,11,13,15,17,19,20,21,23 * * * /usr/share/JD_Script/jd.sh run_09_23 >/tmp/jd_run_09_23.log 2>&1 "
new_task13="#预留位置方便后期增加（不要删除）"
new_task14="###########请将其他定时任务放到说明底下，不要放到说明里面或者上面，防止误删###########"

task() {
	if [[ -e /etc/crontabs/root_back ]]; then
		echo ""
	else
		cp /etc/crontabs/root /etc/crontabs/root_back
	fi

	if [[ `grep -o $new_task1 $cron_file |wc -l` == "1" ]]; then
		cron_help="$green定时任务与设定一致$white"
	else
		sed -i '1,14d' $cron_file
		echo " " >> $cron_file
		sed -i "1i ${new_task1}" $cron_file
		sed -i "1a ${new_task2}" $cron_file
		sed -i "2a ${new_task3}" $cron_file
		sed -i "3a ${new_task4}" $cron_file
		sed -i "4a ${new_task5}" $cron_file
		sed -i "5a ${new_task6}" $cron_file
		sed -i "6a ${new_task7}" $cron_file
		sed -i "7a ${new_task8}" $cron_file
		sed -i "8a ${new_task9}" $cron_file
		sed -i "9a ${new_task10}" $cron_file
		sed -i "10a ${new_task11}" $cron_file
		sed -i "11a ${new_task12}" $cron_file
		sed -i "12a ${new_task13}" $cron_file
		sed -i "13a ${new_task14}" $cron_file
		sed '$s/ //' $cron_file
		/etc/init.d/cron restart
		cron_help="$yellow定时任务更新完成，记得看下你的定时任务，如果有问题可以参考/etc/crontabs/root_back恢复$white"
	fi
}

update() {
	echo -e "$green update$start_script $white"
	echo -e "$green开始下载JS脚本，请稍等$white"
	wget $url/jd_superMarket.js -O $dir_file_js/jd_superMarket.js
	wget $url/jdSuperMarketShareCodes.js -O $dir_file_js/jdSuperMarketShareCodes.js
	wget $url/jd_blueCoin.js -O $dir_file_js/jd_blueCoin.js
	wget $url/jd_redPacket.js -O $dir_file_js/jd_redPacket.js
	wget $url/jd_moneyTree.js -O $dir_file_js/jd_moneyTree.js
	wget $url/jd_fruit.js -O $dir_file_js/jd_fruit.js
	wget $url/jdFruitShareCodes.js -O $dir_file_js/jdFruitShareCodes.js
	wget $url/jd_pet.js -O $dir_file_js/jd_pet.js
	wget $url/jdPetShareCodes.js -O $dir_file_js/jdPetShareCodes.js
	wget $url/jd_plantBean.js -O $dir_file_js/jd_plantBean.js
	wget $url/jdPlantBeanShareCodes.js -O $dir_file_js/jdPlantBeanShareCodes.js
	wget $url/jd_shop.js -O $dir_file_js/jd_shop.js
	wget $url/jd_joy.js -O $dir_file_js/jd_joy.js
	wget $url/jd_joy_steal.js -O $dir_file_js/jd_joy_steal.js
	wget $url/jd_joy_feedPets.js -O $dir_file_js/jd_joy_feedPets.js
	wget $url/jd_joy_reward.js -O $dir_file_js/jd_joy_reward.js
	wget $url/jd_club_lottery.js -O $dir_file_js/jd_club_lottery.js
	wget $url/jd_unsubscribe.js -O $dir_file_js/jd_unsubscribe.js
	wget $url/jd_lotteryMachine.js -O $dir_file_js/jd_lotteryMachine.js
	wget $url/jd_rankingList.js -O $dir_file_js/jd_rankingList.js
	wget $url/jd_speed.js -O $dir_file_js/jd_speed.js
	wget $url/jd_daily_egg.js -O $dir_file_js/jd_daily_egg.js
	wget $url/jd_pigPet.js -O $dir_file_js/jd_pigPet.js
	wget $url/jd_bean_change.js -O $dir_file_js/jd_bean_change.js
	wget $url/jd_dreamFactory.js -O $dir_file_js/jd_dreamFactory.js
	wget $url/jdDreamFactoryShareCodes.js -O $dir_file_js/jdDreamFactoryShareCodes.js
	wget $url/jd_necklace.js -O $dir_file_js/jd_necklace.js
	wget $url/jd_small_home.js -O $dir_file_js/jd_small_home.js
	wget $url/jd_jdfactory.js  -O $dir_file_js/jd_jdfactory.js
	wget $url/jdFactoryShareCodes.js -O $dir_file_js/jdFactoryShareCodes.js
	wget $url/jd_syj.js -O $dir_file_js/jd_syj.js
	wget $url/jd_bean_sign.js -O $dir_file_js/jd_bean_sign.js
	wget $url/jd_jxstory.js -O $dir_file_js/jd_jxstory.js
	wget $url/jdJxStoryShareCodes.js -O $dir_file_js/jdJxStoryShareCodes.js
	wget $url/jd_bean_home.js -O $dir_file_js/jd_bean_home.js #领京豆额外奖励
	wget $url/jd_split.js -O $dir_file_js/jd_split.js    #金榜年终奖 活动2020-12-12日结束
	wget $url/jd_ms_redrain.js -O $dir_file_js/jd_ms_redrain.js #秒杀红包雨 12月1-31日
	wget $url/jd_health.js -O $dir_file_js/jd_health.js #健康抽奖机 ，活动于2020-12-31日结束
	wget $url/jd_car.js -O $dir_file_js/jd_car.js #京东汽车，签到满500赛点可兑换500京豆，一天运行一次即可
	wget $url/jd_kd.js -O $dir_file_js/jd_kd.js #京东快递签到 一天运行一次即可
	wget $url/jd_digital_floor.js -O $dir_file_js/jd_digital_floor.js #数码加购京豆共计25京豆，一天运行一次即可
	wget $url/jd_live_redrain.js -O $dir_file_js/jd_live_redrain.js #直播红包雨每天0,9,11,13,15,17,19,20,21,23可领，每日上限未知
	wget https://raw.githubusercontent.com/MoPoQAQ/Script/main/Me/jx_cfd.js -O $dir_file_js/jx_cfd.js
	wget https://raw.githubusercontent.com/799953468/Quantumult-X/master/Scripts/JD/jd_paopao.js -O $dir_file_js/jd_paopao.js
	rm -rf $dir_file_js/jx_story.js
	additional_settings
	task #更新完全部脚本顺便检查一下计划任务是否有变
	echo -e "$green update$stop_script $white"
}


additional_settings() {
	#京小超默认兑换20豆子(JS已经默认兑换20了)
	#sed -i "s/|| 0/|| 20/g" $dir_file_js/jd_blueCoin.js

	#取消店铺从20个改成50个(没有星推官先默认20吧)
	sed -i "s/|| 20/|| 50/g" $dir_file_js/jd_unsubscribe.js

	#宠汪汪积分兑换奖品改成兑换500豆子，个别人会兑换错误(350积分兑换20豆子，8000积分兑换500豆子要求等级16级，16000积分兑换1000京豆16级以后不能兑换)
	#sed -i "s/let joyRewardName = 20/let joyRewardName = 500/g" $dir_file_js/jd_joy_reward.js

	#京东农场
	old_fruit1="'0a74407df5df4fa99672a037eec61f7e@dbb21614667246fabcfd9685b6f448f3@6fbd26cc27ac44d6a7fed34092453f77@61ff5c624949454aa88561f2cd721bf6',"
	old_fruit2="'b1638a774d054a05a30a17d3b4d364b8@f92cb56c6a1349f5a35f0372aa041ea0@9c52670d52ad4e1a812f894563c746ea@8175509d82504e96828afc8b1bbb9cb3',"
	old_fruit3="'6fbd26cc27ac44d6a7fed34092453f77@61ff5c624949454aa88561f2cd721bf6@9c52670d52ad4e1a812f894563c746ea@8175509d82504e96828afc8b1bbb9cb3',"

	new_fruit1="6632c8135d5c4e2c9ad7f4aa964d4d11@31a2097b10db48429013103077f2f037@5aa64e466c0e43a98cbfbbafcc3ecd02@9046fbd8945f48cb8e36a17fff9b0983"
	new_fruit2="d4e3080b06ed47d884e4ef9852cad568@72abb03ca91a4569933c6c8a62a5622c@ed2b2d28151a482eae49dff2e5a588f8@304b39f17d6c4dac87933882d4dec6bc"
	new_fruit3="3e6f0b7a2d054331a0b5b956f36645a9@5e54362c4a294f66853d14e777584598@f227e8bb1ea3419e9253682b60e17ae5@f0f5edad899947ac9195bf7319c18c7f"
	zuoyou_20190516_fr="367e024351fe49acaafec9ee705d3836@3040465d701c4a4d81347bc966725137@82c164278e934d5aaeb1cf19027a88a3"
	cainiao5_20190516_fr="2a9ccd7f32c245d7a4d6c0fe1cafdd4c"
	shisan_20200213_fr="cf13366e69d648ff9022e0fdce8c172a"
	Jhone_Potte_20200824_fr="64304080a2714e1cac59af03b0009581"
	liandao_20201010_fr="1c6474a197af4b3c8d40c26ec7f11c9e@6f7a7cc42b9342e29163588bafc3782b"
	adong_20201108_fr="3d1985319106483ba83de3366d3716d5"
deng_20201120_fr="bc26d0bdc442421aa92cafcf26a1e148@57cf86ce18ca4f4987ce54fae6182bbd@521a558fcce44fbbb977c8eba4ba0d40@389f3bfe4bdc45e2b1c3e2f36e6be260@26c79946c7cc4477b56d94647d0959f2@26c79946c7cc4477b56d94647d0959f2"
	gomail_20201125_fr="31fee3cdb980491aad3b81d30d769655@0fe3938992cb49d78d4dfd6ce3d344fc"
	baijiezi_20201126_fr="09f7e5678ef44b9385eabde565c42715@ea35a3b050e64027be198e21df9eeece@62595da92a5140a3afc5bc22275bc26c"
	new_fruit_set="'$new_fruit1@$new_fruit2@$new_fruit3@$zuoyou_20190516_fr@$cainiao5_20190516_fr@$shisan_20200213_fr@$Jhone_Potte_20200824_fr@$liandao_20201010_fr@$adong_20201108_fr@$deng_20201120_fr@$gomail_20201125_fr@$baijiezi_20201126_fr',"
	sed -i "s/$old_fruit1/$new_fruit_set/g" $dir_file_js/jd_fruit.js
	sed -i "s/$old_fruit2/$new_fruit_set/g" $dir_file_js/jd_fruit.js
	sed -i "34a $new_fruit_set" $dir_file_js/jd_fruit.js
	sed -i "35a $new_fruit_set" $dir_file_js/jd_fruit.js
	sed -i "36a $new_fruit_set" $dir_file_js/jd_fruit.js
	sed -i "37a $new_fruit_set" $dir_file_js/jd_fruit.js
	sed -i "s/$.isNode() ? 20 : 5/0/g" $dir_file_js/jd_fruit.js

	sed -i "s/$old_fruit1/$new_fruit_set/g" $dir_file_js/jdFruitShareCodes.js
	sed -i "s/$old_fruit3/$new_fruit_set/g" $dir_file_js/jdFruitShareCodes.js
	sed -i "12a $new_fruit_set" $dir_file_js/jdFruitShareCodes.js
	sed -i "13a $new_fruit_set" $dir_file_js/jdFruitShareCodes.js
	sed -i "14a $new_fruit_set" $dir_file_js/jdFruitShareCodes.js
	sed -i "15a $new_fruit_set" $dir_file_js/jdFruitShareCodes.js


	#萌宠
old_pet1="'MTAxODc2NTEzNTAwMDAwMDAwMjg3MDg2MA==@MTAxODc2NTEzMzAwMDAwMDAyNzUwMDA4MQ==@MTAxODc2NTEzMjAwMDAwMDAzMDI3MTMyOQ==@MTAxODc2NTEzNDAwMDAwMDAzMDI2MDI4MQ==@MTAxODcxOTI2NTAwMDAwMDAxOTQ3MjkzMw==',"
	old_pet2="'MTAxODc2NTEzMjAwMDAwMDAzMDI3MTMyOQ==@MTAxODcxOTI2NTAwMDAwMDAyNjA4ODQyMQ==@MTAxODc2NTEzOTAwMDAwMDAyNzE2MDY2NQ==',"
	old_pet3="'MTAxODc2NTEzNTAwMDAwMDAwMjg3MDg2MA==@MTAxODc2NTEzMzAwMDAwMDAyNzUwMDA4MQ==@MTAxODc2NTEzMjAwMDAwMDAzMDI3MTMyOQ==@MTAxODc2NTEzNDAwMDAwMDAzMDI2MDI4MQ==',"

	new_pet1="MTE1NDAxNzcwMDAwMDAwMzk1OTQ4Njk==@MTE1NDQ5OTUwMDAwMDAwMzk3NDgyMDE==@MTAxODEyOTI4MDAwMDAwMDQwMTIzMzcx@MTEzMzI0OTE0NTAwMDAwMDAzOTk5ODU1MQ==@MTAxODc2NTEzMzAwMDAwMDAxOTkzMzM1MQ=="
	new_pet2="MTAxODEyOTI4MDAwMDAwMDM5NzM3Mjk5@MTAxODc2NTEzMDAwMDAwMDAxOTcyMTM3Mw==@MTE1NDQ5MzYwMDAwMDAwMzk2NTY2MTE==@MTE1NDQ5OTUwMDAwMDAwMzk2NTY2MTk==@MTE1NDQ5OTUwMDAwMDAwNDAyNTYyMjM=="
	new_pet3="MTAxODEyOTI4MDAwMDAwMDQwNzYxOTUx@MTE1NDAxNzcwMDAwMDAwNDA4MzcyOTU=="
	zuoyou_20190516_pet="MTEzMzI0OTE0NTAwMDAwMDAzODYzNzU1NQ==@MTE1NDAxNzgwMDAwMDAwMzg2Mzc1Nzc=@MTE1NDAxNzgwMDAwMDAwMzg4MzI1Njc="
	cainiao5_20190516_pet="MTAxODc2NTEzMzAwMDAwMDAyMTg1ODcwMQ=="
	shisan_20200213_pet="MTAxODc2NTEzMjAwMDAwMDAyMjc4OTI5OQ=="
	Jhone_Potte_20200824_pet="MTE1NDAxNzcwMDAwMDAwNDE3MDkwNzE="
	liandao_20201010_pet="MTE1NDQ5MzYwMDAwMDAwNDA3Nzk0MTc=@MTE1NDQ5OTUwMDAwMDAwNDExNjIxMDc="
	adong_20201108_pet="MTAxODc2NTEzMTAwMDAwMDAyMTIwNTc3Nw=="
deng_20201120_pet="MTE1NDUwMTI0MDAwMDAwMDM4MzAwMTI5@MTE1NDQ5OTUwMDAwMDAwMzkxMTY3MTU=@MTE1NDQ5MzYwMDAwMDAwMzgzMzg3OTM=@MTAxODc2NTEzNTAwMDAwMDAyMzk1OTQ4OQ==@MTAxODExNDYxMTAwMDAwMDAwNDA2MjUzMTk=@MTE1NDUwMTI0MDAwMDAwMDM5MTg4MTAz"
	gomail_20201125_pet="MTE1NDQ5MzYwMDAwMDAwMzcyOTA4MDU=@MTE1NDAxNzYwMDAwMDAwNDE0MzQ4MTE="
	baijiezi_20201126_pet="MTE1NDAxNzgwMDAwMDAwNDE0NzQ3ODM=@MTE1NDUyMjEwMDAwMDAwNDA4MTg2NDE=@MTAxODc2NTEzNTAwMDAwMDAwNTI4ODM0NQ=="
	new_pet_set="'$new_pet1@$new_pet2@$new_pet3@$zuoyou_20190516_pet@$cainiao5_20190516_pet@$shisan_20200213_pet@$Jhone_Potte_20200824_pet@$liandao_20201010_pet@$adong_20201108_pet@$deng_20201120_pet@$gomail_20201125_pet@$baijiezi_20201126_pet',"
	sed -i "s/$old_pet1/$new_pet_set/g" $dir_file_js/jd_pet.js
	sed -i "s/$old_pet2/$new_pet_set/g" $dir_file_js/jd_pet.js
	sed -i "35a $new_pet_set" $dir_file_js/jd_pet.js
	sed -i "36a $new_pet_set" $dir_file_js/jd_pet.js
	sed -i "37a $new_pet_set" $dir_file_js/jd_pet.js
	sed -i "38a $new_pet_set" $dir_file_js/jd_pet.js
	sed -i "s/$.isNode() ? 20 : 5/0/g" $dir_file_js/jd_pet.js

	sed -i "s/$old_pet2/$new_pet_set/g" $dir_file_js/jdPetShareCodes.js
	sed -i "s/$old_pet3/$new_pet_set/g" $dir_file_js/jdPetShareCodes.js
	sed -i "12a $new_pet_set" $dir_file_js/jdPetShareCodes.js
	sed -i "13a $new_pet_set" $dir_file_js/jdPetShareCodes.js
	sed -i "14a $new_pet_set" $dir_file_js/jdPetShareCodes.js
	sed -i "15a $new_pet_set" $dir_file_js/jdPetShareCodes.js


	#种豆
	old_plantBean1="'66j4yt3ebl5ierjljoszp7e4izzbzaqhi5k2unz2afwlyqsgnasq@olmijoxgmjutyrsovl2xalt2tbtfmg6sqldcb3q@e7lhibzb3zek27amgsvywffxx7hxgtzstrk2lba@e7lhibzb3zek32e72n4xesxmgc2m76eju62zk3y',"
	old_plantBean2="'olmijoxgmjutyx55upqaqxrblt7f3h26dgj2riy@4npkonnsy7xi3p6pjfxg6ct5gll42gmvnz7zgoy@6dygkptofggtp6ffhbowku3xgu@mlrdw3aw26j3wgzjipsxgonaoyr2evrdsifsziy',"
	old_plantBean3="'66j4yt3ebl5ierjljoszp7e4izzbzaqhi5k2unz2afwlyqsgnasq@olmijoxgmjutyrsovl2xalt2tbtfmg6sqldcb3q@e7lhibzb3zek27amgsvywffxx7hxgtzstrk2lba@olmijoxgmjutyx55upqaqxrblt7f3h26dgj2riy',"
	old_plantBean4="'4npkonnsy7xi3p6pjfxg6ct5gll42gmvnz7zgoy@6dygkptofggtp6ffhbowku3xgu@mlrdw3aw26j3wgzjipsxgonaoyr2evrdsifsziy@mlrdw3aw26j3wgzjipsxgonaoyr2evrdsifsziy',"

	new_plantBean1="4npkonnsy7xi3n46rivf5vyrszud7yvj7hcdr5a@mlrdw3aw26j3xeqso5asaq6zechwcl76uojnpha@nkvdrkoit5o65lgaousaj4dqrfmnij2zyntizsa@3wmn5ktjfo7ukgaymbrakyuqry3h7wlwy7o5jii"
	new_plantBean2="olmijoxgmjutyy7u5s57pouxi5teo3r4r2mt36i@chcdw36mwfu6bh72u7gtvev6em@olmijoxgmjutzh77gykzjkyd6zwvkvm6oszb5ni@4npkonnsy7xi3smz2qmjorpg6ldw5otnabrmlei"
	new_plantBean3="e7lhibzb3zek2zin4gnao3gynqwqgrzjyopvbua@e7lhibzb3zek234ckc2fm2yvkj5cbsdpe7y6p2a@crydelzlvftgpeyuedndyctelq@u72q4vdn3zes24pmx6lh34pdcinjjexdfljybvi"
	zuoyou_20190516_pb="sz5infcskhz3woqbns6eertieu@mxskszygpa3kaouswi7rele2ji@4npkonnsy7xi3vk7khql3p7gkpodivnbwjoziga"
	cainiao5_20190516_pb="mlrdw3aw26j3wuxtla52mzrnywbtfqzw6bzyi3y"
	shisan_20200213_pb="mlrdw3aw26j3xzd26qnacr3cfnm4zggngukbhny"
	Jhone_Potte_20200824_pb="olmijoxgmjutzcbkzw4njrhy3l3gwuh6g2qzsvi"
	liandao_20201010_pb="nxawbkvqldtx4wdwxxbkf23g6y@l4ex6vx6yynouxxefa4hfq6z3in25fmktqqwtca"
	adong_20201108_pb="qhw4z5vauoy4gfkaybvpmxvjfi"
deng_20201120_pb="e7lhibzb3zek3knwnjhrbaadekphavflo22jqii@olmijoxgmjutzfvkt4iu7xobmplveczy2ogou3i@f3er4cqcqgwogenz3dwsg7owhy@eupxefvqt76x2ssddhd35aysfrchgqeijzo2wdi@3en43v3ev6tvx55oefp3vb2xure67mm3kwgsm6a@nkvdrkoit5o657wm7ui35qcu2dmtir7t5h7sema"
	gomail_20201125_pb="yzhv4vq2u2tan56h4a764rocbe@4npkonnsy7xi2rducm544znpdzi2gnyg5ygrqei"
	baijiezi_20201126_pb="m6brcm36t5fvxhxnhnjzssq3fauk3bdje2jbnra@mlkc4vnryrhbob7aruocema224@vv3gwhnjzvf5scyicvcrylwldjf2yqvagsa35cy"
	new_plantBean_set="'$new_plantBean1@$new_plantBean2@$new_plantBean3@$zuoyou_20190516_pb@$cainiao5_20190516_pb@$shisan_20200213_pb@$Jhone_Potte_20200824_pb@$@$liandao_20201010_pb@$adong_20201108_pb@$deng_20201120_pb@$gomail_20201125_pb@$baijiezi_20201126_pb',"
	sed -i "s/$old_plantBean1/$new_plantBean_set/g" $dir_file_js/jd_plantBean.js
	sed -i "s/$old_plantBean2/$new_plantBean_set/g" $dir_file_js/jd_plantBean.js
	sed -i "39a $new_plantBean_set" $dir_file_js/jd_plantBean.js
	sed -i "40a $new_plantBean_set" $dir_file_js/jd_plantBean.js
	sed -i "41a $new_plantBean_set" $dir_file_js/jd_plantBean.js
	sed -i "42a $new_plantBean_set" $dir_file_js/jd_plantBean.js
	sed -i "s/$.isNode() ? 20 : 5/0/g" $dir_file_js/jd_plantBean.js

	sed -i "s/$old_plantBean3/$new_plantBean_set/g" $dir_file_js/jdPlantBeanShareCodes.js
	sed -i "s/$old_plantBean4/$new_plantBean_set/g" $dir_file_js/jdPlantBeanShareCodes.js
	sed -i "12a $new_plantBean_set" $dir_file_js/jdPlantBeanShareCodes.js
	sed -i "13a $new_plantBean_set" $dir_file_js/jdPlantBeanShareCodes.js
	sed -i "14a $new_plantBean_set" $dir_file_js/jdPlantBeanShareCodes.js
	sed -i "15a $new_plantBean_set" $dir_file_js/jdPlantBeanShareCodes.js


	#京喜工厂
	old_dreamFactory="'V5LkjP4WRyjeCKR9VRwcRX0bBuTz7MEK0-E99EJ7u0k=@Bo-jnVs_m9uBvbRzraXcSA==',"
	old_dreamFactory1="'1uzRU5HkaUgvy0AB5Q9VUg==@PDPM257r_KuQhil2Y7koNw==',"
	new_dreamFactory="'4HL35B_v85-TsEGQbQTfFg==@q3X6tiRYVGYuAO4OD1-Fcg==@Gkf3Upy3YwQn2K3kO1hFFg==@w8B9d4EVh3e3eskOT5PR1A==@FyYWfETygv_4XjGtnl2YSg==@us6se4fFC6cSjHDSS_ScMw==@oWcboKZa9XxTSWd28tCEPA==@sboe5PFeXgL2EWpxucrKYw==@rm-j1efPyFU50GBjacgEsw==@1rQLjMF_eWMiQ-RAWARW_w==@bHIVoTmS-fHA6G9ixqnOxfjRNGe1YfJzIbBoF-NEAOw=@6h514zWW6JNRE_Kp-L4cjA==',"

	sed -i "s/'V5LkjP4WRyjeCKR9VRwcRX0bBuTz7MEK0-E99EJ7u0k=', 'PDPM257r_KuQhil2Y7koNw==', "gB99tYLjvPcEFloDgamoBw=="/'4HL35B_v85-TsEGQbQTfFg==', 'q3X6tiRYVGYuAO4OD1-Fcg==', 'Gkf3Upy3YwQn2K3kO1hFFg=='/g" $dir_file_js/jd_dreamFactory.js
	sed -i "s/randomCount = 1/randomCount = 0/g" $dir_file_js/jd_dreamFactory.js
	sed -i "s/$.isNode() ? 20 : 5/0/g" $dir_file_js/jd_dreamFactory.js

	sed -i "s/$old_dreamFactory/$new_dreamFactory/g" $dir_file_js/jdDreamFactoryShareCodes.js
	sed -i "s/$old_dreamFactory1/$new_dreamFactory/g" $dir_file_js/jdDreamFactoryShareCodes.js
	sed -i "12a $new_dreamFactory" $dir_file_js/jdDreamFactoryShareCodes.js
	sed -i "13a $new_dreamFactory" $dir_file_js/jdDreamFactoryShareCodes.js
	sed -i "14a $new_dreamFactory" $dir_file_js/jdDreamFactoryShareCodes.js
	sed -i "15a $new_dreamFactory" $dir_file_js/jdDreamFactoryShareCodes.js


	#京喜工厂-金牌厂长
	new_jdJxStoryShareCodes="'xTlGGIL-9JvzV694GpP6Gba8_zk0emJWtyQkQK0otrw=@ijeY8Ncm2eztoQMx4j3LPHswvSkak4Tq3uIuIRzLwcI=@VxcUisKVRxroaObG1_S9WOa-M2odzvod3T2C8i08KQE=@mPQKBbK0GKzKQuiZJr2JWt_p64iCef8g6lu0y2xNFLU=@jrXVUabGAPM3g2ia6CP_8omSeCOuVDuc8WtTTH-P5tA=',"

	sed -i "s/'qSDHMwUOz7onHcMyaju4KmdSXWf0dlv7LVnTt1Wzemo=@iuGNoGYvk9YdEImUAz25Wyzm7oeggrm0JSIYgZdHJGI=', 'iuGNoGYvk9YdEImUAz25Wyzm7oeggrm0JSIYgZdHJGI='/'xTlGGIL-9JvzV694GpP6Gba8_zk0emJWtyQkQK0otrw=', 'ijeY8Ncm2eztoQMx4j3LPHswvSkak4Tq3uIuIRzLwcI=', 'VxcUisKVRxroaObG1_S9WOa-M2odzvod3T2C8i08KQE='/g" $dir_file_js/jd_jxstory.js
	sed -i "s/randomCount = 3/randomCount = 0/g" $dir_file_js/jd_jxstory.js
	sed -i "s/'',/$new_jdJxStoryShareCodes/g" $dir_file_js/jdJxStoryShareCodes.js
	sed -i "12a $new_jdJxStoryShareCodes" $dir_file_js/jdJxStoryShareCodes.js
	sed -i "13a $new_jdJxStoryShareCodes" $dir_file_js/jdJxStoryShareCodes.js
	sed -i "14a $new_jdJxStoryShareCodes" $dir_file_js/jdJxStoryShareCodes.js
	sed -i "15a $new_jdJxStoryShareCodes" $dir_file_js/jdJxStoryShareCodes.js

	#东东工厂
	old_jdfactory="\`P04z54XCjVWnYaS5u2ak7ZCdan1Bdd2GGiWvC6_uERj\`, 'P04z54XCjVWnYaS5m9cZ2ariXVJwHf0bgkG7Uo'"
	#new_jdfactory="'P04z54XCjVWnYaS5m9cZ2f83X0Zl_Dd8CqABxo', 'P04z54XCjVWnYaS5m9cZ2Wui31Oxg3QPwI97G0', 'P04z54XCjVWnYaS5m9cZz-inDgt5gUTV9zVCg', 'P04z54XCjVWnYaS5m9cZ2T8jntInKkhvhlkIu4', 'P04z54XCjVWnYaS5m9cZ2eq2S1OxAqmz-x3vbg',"
	new_jdfactory1="'P04z54XCjVWnYaS5m9cZ2f83X0Zl_Dd8CqABxo@P04z54XCjVWnYaS5m9cZ2Wui31Oxg3QPwI97G0@P04z54XCjVWnYaS5m9cZz-inDgt5gUTV9zVCg@P04z54XCjVWnYaS5m9cZ2T8jntInKkhvhlkIu4@P04z54XCjVWnYaS5m9cZ2eq2S1OxAqmz-x3vbg@P04z54XCjVWnYaS5mZQUSm92H5L@P04z54XCjVWnYaS5mlKD2U@P04z54XCjVWnYaS5n1LTCj93Q@P04z54XCjVWnYaS5m9cZ2er3ylCk-4HZadagsg',"
	sed -i "s/'',/$new_jdfactory1 $new_jdfactory1 $new_jdfactory1/g" $dir_file_js/jdFactoryShareCodes.js
	sed -i "s/$old_jdfactory/$new_jdfactory1/g" $dir_file_js/jd_jdfactory.js
	sed -i "s/$.isNode() ? 20 : 5/0/g" $dir_file_js/jd_jdfactory.js
	if [[ -f "/usr/share/JD_Script/1.txt" ]]; then
		sed -i "s/let wantProduct = \`\`/let wantProduct = \`灵蛇机械键盘\`/g" $dir_file_js/jd_jdfactory.js
	elif [[ -f "/usr/share/JD_Script/2.txt" ]]; then
		sed -i "s/let wantProduct = \`\`/let wantProduct = \`电视\`/g" $dir_file_js/jd_jdfactory.js
	else
		echo ""
	fi


	#东东超市
	sed -i '323,338d' jd_superMarket.js
	sed -i "s/eU9Ya-y2N_5z9DvXwyIV0A/eU9Ya-iyZ68kpWrRmXBFgw/g" $dir_file_js/jd_superMarket.js
	sed -i "s/aURoM7PtY_Q/eU9Ya-iyZ68kpWrRmXBFgw/g" $dir_file_js/jd_superMarket.js
	sed -i "s/eU9Ya-y2N_5z9DvXwyIV0A/eU9YabrkZ_h1-GrcmiJB0A/g" $dir_file_js/jd_superMarket.js
	sed -i "s/eU9YaeS3Z6ol8zrRmnMb1Q/eU9YabrkZ_h1-GrcmiJB0A/g" $dir_file_js/jd_superMarket.js


	#金榜年终奖
	old_jdsplit="\`P04z54XCjVUnIaW5nJcXCCyoR8C6p8txXBH\`, 'P04z54XCjVUnIaW5m9cZ2T6jChKki0Hfndla5k', 'P04z54XCjVUnIaW5u2ak7ZCdan1BT0NlbBGZ1-rnMYj', 'P04z54XCjVUnIaW5m9cZ2ariXVJwI64DaVTNXQ'"
	new_jdsplit="'P04z54XCjVUnIaW5m9cZ2f83X0Zl5Q3j7iYXJY', 'P04z54XCjVUnIaW5m9cZ2Wui31Oxvlnad1eTuE', 'P04z54XCjVUnIaW5m9cZz-inDgt5sQ4KtrDjw'"
	sed -i "s/$old_jdsplit/$new_jdsplit/g" $dir_file_js/jd_split.js

	#健康抽奖机 ，活动于2020-12-31日结束
	old_jdhealth="\`P04z54XCjVUnoaW5nJcXCCyoR8C6i9QR16e\`, 'P04z54XCjVUnoaW5m9cZ2T6jChKkh8FWbFAplQ', `P04z54XCjVUnoaW5u2ak7ZCdan1Bdbpik_F9ud7lznm`, `P04z54XCjVUnoaW5m9cZ2ariXVJwFN5uKHNqnc`"
	new_jdhealth="'P04z54XCjVUnoaW5m9cZ2f83X0Zl9nlF826jjE', 'P04z54XCjVUnoaW5m9cZ2Wui31Oxj26WlIf23s', 'P04z54XCjVUnoaW5m9cZz-inDgt5kxStfLzOw'"
	sed -i "s/$old_jdhealth/$new_jdhealth/g" $dir_file_js/jd_health.js

	#数码加购京豆
	old_jd_digital="\`40cd108f-9eed-4897-b795-45a5b221cd6b\`,'9d4262a5-1a02-4ae7-8a86-8d070d531464'"
	new_jd_digital="'6e606555-91c0-4bb3-838e-b38b98b643d5', 'd8e3dc32-8693-47b3-99eb-ffc2b1c26967', '54d2990b-b4f2-4af3-85dd-4fda94e1a70e'"
	sed -i "s/$old_jd_digital/$new_jd_digital/g" $dir_file_js/jd_digital_floor.js
	sed -i "s/$.isNode() ? 20 : 5/0/g" $dir_file_js/jd_digital_floor.js



}

update_script() {
	echo -e "$green update_script$start_script $white"
	cd $dir_file
	git fetch --all
	git reset --hard origin/main
	echo -e "$green update_script$stop_script $white"
}


run_0() {
	echo -e "$green run_0$start_script $white"
	run_08_12_16
	$node $dir_file_js/jd_redPacket.js #京东全民开红包，没时间要求
	$node $dir_file_js/jd_lotteryMachine.js #京东抽奖机
	$node $dir_file_js/jd_rankingList.js #京东排行榜签到领京豆
	run_09_23
	run_06_18
	run_10_15_20
	run_01
	run_02
	run_03
	run_030
	$node $dir_file_js/jd_small_home.js #东东小窝
	$node $dir_file_js/jd_syj.js #十元街签到,一天一次即可，一周30豆子
	$node $dir_file_js/jd_paopao.js #京东泡泡大战,一天一次
	$node $dir_file_js/jd_ms_redrain.js #秒杀红包雨 12月1-31日
	$node $dir_file_js/jd_split.js  #金榜年终奖 活动2020-12-12日结束
	$node $dir_file_js/jd_health.js #健康抽奖机 ，活动于2020-12-31日结束
	$node $dir_file_js/jd_car.js #京东汽车，签到满500赛点可兑换500京豆，一天运行一次即可
	$node $dir_file_js/jd_kd.js #京东快递签到 一天运行一次即可
	$node $dir_file_js/jd_bean_home.js #领京豆额外奖励
	$node $dir_file_js/jd_digital_floor.js #数码加购京豆共计25京豆，一天运行一次即可
	$node $dir_file_js/jd_bean_sign.js #京东多合一签到
	$node $dir_file_js/jd_unsubscribe.js #取关店铺，没时间要求
	$node $dir_file_js/jd_bean_change.js #京豆变更
	echo -e "$green run_0$stop_script $white"
}

run_030() {
	echo -e "$green run_030$start_script $white"
	$node $dir_file_js/jd_dreamFactory.js #京喜工厂 30分钟运行一次
	$node $dir_file_js/jd_jdfactory.js #东东工厂，不是京喜工厂
	echo -e "$green run_030$stop_script $white"
}

run_01() {
	echo -e "$green run_01$start_script $white"
	$node $dir_file_js/jd_plantBean.js & $node $dir_file_js/jd_joy_feedPets.js #种豆得豆，没时间要求，一个小时收一次瓶子 & #宠汪汪喂食一个小时喂一次
	echo -e "$green run_01$stop_script $white"
}

run_02() {
	echo -e "$green run_02$start_script $white"
	$node $dir_file_js/jd_moneyTree.js #京东摇钱树，7-9 11-13 18-20签到 每两小时收一次
	$node $dir_file_js/jd_club_lottery.js #摇京豆，没时间要求
	echo -e "$green run_02$stop_script $white"
}

run_03() {
	echo -e "$green run_03$start_script $white"
	$node $dir_file_js/jd_speed.js #天天加速 3小时运行一次，打卡时间间隔是6小时
	echo -e "$green run_03$stop_script $white"
}


run_06_18() {
	echo -e "$green run_06_18$start_script $white"
	$node $dir_file_js/jd_shop.js #进店领豆，早点领，一天也可以执行两次以上
	$node $dir_file_js/jd_fruit.js #东东水果，6-9点 11-14点 17-21点可以领水滴
	$node $dir_file_js/jd_joy.js #jd宠汪汪，零点开始，11.30-15:00 17-21点可以领狗粮
	$node $dir_file_js/jd_pet.js #东东萌宠，跟手机商城同一时间
	$node $dir_file_js/jd_joy_steal.js #可偷好友积分，零点开始，六点再偷一波狗粮
	$node $dir_file_js/jd_daily_egg.js #天天提鹅蛋，需要有金融app，没有顶多报错问题不大
	$node $dir_file_js/jd_pigPet.js #金融养猪，需要有金融app，没有顶多报错问题不大
	$node $dir_file_js/jd_superMarket.js #东东超市,6点 18点多加两场用于收金币
	echo -e "$green run_06_18$stop_script $white"
}

run_08_12_16() {
	echo -e "$green run_08_12_16$start_script $white"
	$node $dir_file_js/jd_blueCoin.js #东东超市兑换，有次数限制，没时间要求
	$node $dir_file_js/jd_joy_reward.js #宠汪汪积分兑换奖品，有次数限制，每日京豆库存会在0:00、8:00、16:00更新，经测试发现中午12:00也会有补发京豆
	$node $dir_file_js/jd_jxstory.js #京喜金牌厂长
	echo -e "$green run_08_12_16$stop_script $white"
}

run_09_23() {
	$node $dir_file_js/jd_live_redrain.js #直播红包雨每天0,9,11,13,15,17,19,20,21,23可领，每日上限未知
}


run_10_15_20() {
	echo -e "$green run_10_15_20$start_script $white"
	$node $dir_file_js/jd_superMarket.js #东东超市,0 10 15 20四场补货加劵
	$node $dir_file_js/jd_necklace.js  #点点券 大佬0,20领一次先扔这里后面再改
	$node $dir_file_js/jx_cfd.js #京东财富岛 有一日三餐任务
	echo -e "$green run_10_15_20$stop_script $white"
}

help() {
	task
	clear
	echo ----------------------------------------------------
	echo "	     JD.sh $version 使用说明"
	echo ----------------------------------------------------
	echo -e "$yellow 1.文件说明$white"
	echo -e "$green $dir_file/jdCookie.js $white 在此脚本内填写JD Cookie 脚本内有说明"
	echo -e "$green $dir_file/sendNotify.js $white 在此脚本内填写推送服务的KEY，可以不填"
	echo -e "$green $dir_file/jd.sh $white JD_Script的本体（作用就是帮忙下载js脚本，js脚本是核心）"
	echo -e "$yellow JS脚本作用请查询：$white $green https://github.com/lxk0301/jd_scripts $white"
	echo -e "$yellow 浏览器获取京东cookie教程：$white $green https://github.com/lxk0301/jd_scripts/blob/master/backUp/GetJdCookie.md $white"
	echo ""
	echo -e "$yellow 2.jd.sh脚本命令$white"
	echo -e "$green sh \$jd update $white        #下载js脚本"
	echo -e "$green sh \$jd update_script $white #更新JD_Script "
	echo -e "$green sh \$jd run_0 $white         #运行全部脚本 $yellow#第一次安装完成运行这句，前提你把jdCookie.js填完整$white"
	echo -e "$green sh \$jd run_030 $white        #运行run_030模块里的命令"
	echo -e "$green sh \$jd run_01 $white        #运行run_01模块里的命令 "
	echo -e "$green sh \$jd run_02 $white        #运行run_02模块里的命令"
	echo -e "$green sh \$jd run_03 $white        #运行run_03模块里的命令"
	echo -e "$green sh \$jd run_06_18 $white     #运行run_06_18模块里的命令"
	echo -e "$green sh \$jd run_08_12_16 $white     #运行run_08_12_16模块里的命令"
	echo -e "$green sh \$jd run_10_15_20 $white  #运行run_10_15_20模块里的命令"
	echo " 如果不喜欢这样，你也可以直接cd $jd_file/js,然后用node 脚本名字.js "
	echo ""
	echo ""
	echo -e "$yellow 3.本脚本的计划任务$white"
	echo " $new_task2"
	echo " $new_task3"
	echo " $new_task4"
	echo " $new_task5"
	echo " $new_task6"
	echo " $new_task7"
	echo " $new_task8"
	echo " $new_task9"
	echo " $new_task10"
	echo " $new_task11"
	echo -e "$yellow 检测定时任务:$white $cron_help"
	echo ""
	echo -e "$yellow 4.检测脚本是否最新:$white $Script_status "
	echo ""
	echo -e "$yellow 5.JD_Script报错你可以反馈到这里:$white$green https://github.com/ITdesk01/JD_Script/issues$white"
	echo ""
	echo -e "本脚本基于$green x86主机测试$white，一切正常，其他的机器自行测试，满足依赖一般问题不大"
	echo ----------------------------------------------------
	echo " 		by：ITdesk"
	echo ----------------------------------------------------
}

description_if() {
	if [[ ! -d "$dir_file" ]]; then
		cp -r $(pwd)  $dir_file && chmod 777 $dir_file/jd.sh
	fi
	
	if [[ ! -d "$dir_file/js" ]]; then
		mkdir -p $dir_file/js
		update
	fi
	
	if [[ -f "/usr/share/JD_Script/jdCookie.js" ]]; then
		echo "jdCookie.js存在"
	else 
		wget $url/jdCookie.js -O $dir_file/jdCookie.js
		ln -s $dir_file/jdCookie.js $dir_file_js/jdCookie.js
	fi

	if [[ -f "/usr/share/JD_Script/sendNotify.js" ]]; then
		echo "sendNotify.js存在"
		clear
	else
		wget $url/sendNotify.js -O $dir_file/sendNotify.js	
		ln -s $dir_file/sendNotify.js $dir_file_js/sendNotify.js
	fi

	echo "稍等一下，正在取回远端脚本源码，用于比较现在脚本源码，速度看你网络"
	cd $dir_file_js
	git fetch
	if [[ $? -eq 0 ]]; then
		echo ""
	else
		echo -e "$red>> 取回分支没有成功，重新执行代码$white"
		description_if
	fi
	clear
	git_branch=$(git branch -v | grep -o behind )
	if [[ "$git_branch" == "behind" ]]; then
		Script_status="$red建议更新$white (可以运行$green sh \$jd update_script && sh \$jd update && sh \$jd$white更新 )"
	else
		Script_status="$green最新$white"
	fi

	#添加系统变量
	jd_script_path=$(cat /etc/profile | grep -o jd.sh | wc -l)
	if [[ "$jd_script_path" == "0" ]]; then
		echo "export jd_file=/usr/share/JD_Script" |  tee -a /etc/profile
		echo "export jd=/usr/share/JD_Script/jd.sh" |  tee -a /etc/profile
		echo "-----------------------------------------------------------------------"
		echo ""
		echo -e "$green添加jd变量成功,重启系统以后无论在那个目录输入 bash \$jd 都可以运行脚本$white"
		echo ""
		echo ""
		echo -e "          $green直接回车会重启你的系统!!!，如果不需要马上重启ctrl+c取消$white"
		echo "-----------------------------------------------------------------------"
		read a
		reboot	
	else
			echo "变量已经添加"
	fi
	help
}

action1="$1"
if [[ -z $action1 ]]; then
	description_if
else
	case "$action1" in
			update|update_script|run_0|run_01|run_06_18|run_10_15_20|run_02|run_03|run_030|task|run_08_12_16|run_09_23)
			$action1
			;;
			*)
			help
			;;
esac
fi

