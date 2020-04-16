#!/bin/sh
set -e
# Scrypta for Linux installation script
#
# See https://wiki-it.scryptachain.org/scrypta-full-node/come-installare-il-lyra-wallet/linux for the installation steps.
#
# This script is meant for quick & easy install via:
#   $ curl -fsSL https://get.scryptachain.org -o get-scrypta.sh
#   $ sh get-scrypta.sh
#
# NOTE: Make sure to verify the contents of the script
#       you downloaded matches the contents of install.sh
#       located at https://github.com/scryptachain/scrypta-install
#       before executing.
#
# Git commit from https://github.com/scryptachain/scrypta-install when
# the script was uploaded (Should only be modified by upload job):
SCRIPT_COMMIT_SHA="${LOAD_SCRIPT_COMMIT_SHA}"

do_install() {
	echo "# Executing scrypta install script, commit: $SCRIPT_COMMIT_SHA"

	user="$(id -un 2>/dev/null || true)"
	sh_c='sh -c'
	if [ "$user" != 'root' ]; then
		if command_exists sudo; then
			sh_c='sudo -E sh -c'
		elif command_exists su; then
			sh_c='su -c'
		else
			cat >&2 <<-'EOF'
			Error: this installer needs the ability to run commands as root.
			We are unable to find either "sudo" or "su" available to make this happen.
			EOF
			exit 1
		fi
	fi

	# perform some very rudimentary platform detection
	lsb_dist=$( get_distribution )
	lsb_dist="$(echo "$lsb_dist" | tr '[:upper:]' '[:lower:]')"
	case "$lsb_dist" in

		ubuntu)
			if command_exists lsb_release; then
				dist_version="$(lsb_release --codename | cut -f2)"
			fi
			if [ -z "$dist_version" ] && [ -r /etc/lsb-release ]; then
				dist_version="$(. /etc/lsb-release && echo "$DISTRIB_CODENAME")"
			fi
		;;

		debian|raspbian)
			dist_version="$(sed 's/\/.*//' /etc/debian_version | sed 's/\..*//')"
			case "$dist_version" in
				10)
					dist_version="buster"
				;;
				9)
					dist_version="stretch"
				;;
				8)
					dist_version="jessie"
				;;
			esac
		;;

		centos)
			if [ -z "$dist_version" ] && [ -r /etc/os-release ]; then
				dist_version="$(. /etc/os-release && echo "$VERSION_ID")"
			fi
		;;

		rhel|ol|sles)
			ee_notice "$lsb_dist"
			exit 1
			;;

		*)
			if command_exists lsb_release; then
				dist_version="$(lsb_release --release | cut -f2)"
			fi
			if [ -z "$dist_version" ] && [ -r /etc/os-release ]; then
				dist_version="$(. /etc/os-release && echo "$VERSION_ID")"
			fi
		;;

	esac
	
	$sh_c "apt-get update"
	$sh_c "apt-get install -y software-properties-common"
	$sh_c "add-apt-repository -y ppa:bitcoin/bitcoin"	
	$sh_c "apt-get update"
	$sh_c "apt-get install libdb4.8-dev libdb4.8++-dev -y"
	$sh_c "apt-get -y install build-essential autoconf automake libboost-all-dev libleveldb-dev libgmp-dev libgmp3-dev libssl-dev libcurl4-openssl-dev libcrypto++-dev libqrencode-dev libminiupnpc-dev autogen libtool git libevent-dev libprotobuf-dev"
	$sh_c "apt-get -y install curl g++ git-core pkg-config libtool faketime bsdmainutils mingw-w64 g++-mingw-w64 nsis zip ca-certificates python"
	$sh_c "apt-get -y install libzmq3-dev"
	$sh_c "apt-get -y install libqt5gui5 libqt5core5a libqt5dbus5 qttools5-dev qttools5-dev-tools libprotobuf-dev protobuf-compiler"
	$sh_c "apt-get -y install libqrencode-dev"
	$sh_c "apt-get -y install libssl1.0-dev"	
	git clone https://github.com/scryptachain/scrypta
	cd scrypta
	./autogen.sh
	./configure
	sudo make
	chmod 777 -R src/qt
}

# wrapped up in a function so that we have some protection against only getting
# half the file during "curl | sh"
do_install

