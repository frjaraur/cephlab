create:
	vagrant up
clean:
	vagrant destroy -f 
	rm -rf ./tmp_deploying_stage

poweroff:
	vboxmanage controlvm storage1 poweroff
	vboxmanage controlvm storage2 poweroff
	vboxmanage controlvm storage3 poweroff
	vboxmanage controlvm storage4 poweroff

poweron:
	vboxmanage startvm storage1 --type headless
	vboxmanage startvm storage2 --type headless
	vboxmanage startvm storage3 --type headless
	vboxmanage startvm storage4 --type headless
