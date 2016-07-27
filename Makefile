create:
	vagrant up
clean:
	vagrant destroy -f 
	rm -rf ./tmp_deploying_stage

poweroff:
	vboxmanage controlvm ceph1 poweroff
	vboxmanage controlvm ceph2 poweroff
	vboxmanage controlvm ceph3 poweroff

poweron:
	vboxmanage startvm ceph1 --type headless
	vboxmanage startvm ceph2 --type headless
	vboxmanage startvm ceph3 --type headless
