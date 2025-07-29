#!/bin/bash
# Script to install NDK
# Author MrIkso

# Modified by JKas(jkasdbt) for AndroidPE


# --- loading default presets ---
. $SCRIPTS/clrs.sh


install_dir=$HOME
sdk_dir=$install_dir/android-sdk
cmake_dir=$sdk_dir/cmake
ndk_base_dir=$sdk_dir/ndk

ndk_dir=""
ndk_ver=""
ndk_ver_name=""
ndk_file_name=""
ndk_installed=false
cmake_installed=false

run_install_cmake() {
	download_cmake 3.10.2
	download_cmake 3.18.1
	download_cmake 3.22.1
	download_cmake 3.25.1
}

download_cmake() {
	# download cmake
	cmake_version=$1
	log "${BOLD}Downloading ${NC}cmake-$cmake_version..."
	wget https://github.com/MrIkso/AndroidIDE-NDK/releases/download/cmake/cmake-"$cmake_version"-android-aarch64.zip --no-verbose --show-progress -N
	installing_cmake "$cmake_version"
}

download_ndk() {
	# download NDK
	log "Downloading NDK ${BCYAN}$1..."
	wget $2 --no-verbose --show-progress -N
}

fix_ndk_musl() {
	# create missing link
	if [ -d "$ndk_dir" ]; then
		_info "Creating missing links..."
		cd "$ndk_dir"/toolchains/llvm/prebuilt || exit
		ln -s linux-arm64 linux-aarch64
		cd "$ndk_dir"/prebuilt || exit
		ln -s linux-arm64 linux-aarch64
  		cd "$ndk_dir"/shader-tools || exit
    		ln -s linux-arm64 linux-aarch64 
		ndk_installed=true
	else
		_warning "NDK does not exists."
	fi
}

installing_cmake() {
	cmake_version=$1
	cmake_file=cmake-"$cmake_version"-android-aarch64.zip
	# unzip cmake
	if [ -f "$cmake_file" ]; then
		_info2 "Unziping cmake..."
		unzip -qq "$cmake_file" -d "$cmake_dir"
		rm "$cmake_file"
		# set executable permission for cmake
		chmod -R +x "$cmake_dir"/"$cmake_version"/bin
		cmake_installed=true
        _info "unziping cmake finished successfully"
        log ""
	else
		_warning "$cmake_file does not exists."
	fi
}

log "Select the NDK version you need install : "

select item in r26d r27d r28c r29-beta2 Quit; do
	case $item in
  	"r26d")
		ndk_ver="26.3.11579264"
		ndk_ver_name="r26d"
		break
		;;
  	"r27d")
		ndk_ver="27.3.13750724"
		ndk_ver_name="r27d"
		break
		;;
  	"r28c")
		ndk_ver="28.2.13676358"
		ndk_ver_name="r28c"
		break
		;;
	"r29-beta2")
		ndk_ver="29.0.13599879"
		ndk_ver_name="r29-beta2"
		break
		;;
	"Quit")
		_info "Process canceled."
		exit
		;;
	*)
		_warning "('~') ${ERROR}ERROR !!!"
		;;
	esac
done

_info "Selected this version $ndk_ver_name ($ndk_ver) to install"
_warning "warning" "${BOLD}This NDK only for aarch64"
cd "$install_dir" || exit
# checking if previous installed NDK and cmake

ndk_dir="$ndk_base_dir/$ndk_ver"
ndk_file_name="android-ndk-$ndk_ver_name-aarch64-linux-musl.tar.xz"

if [ -d "$ndk_dir" ]; then
	log "$ndk_dir exists. ${BOLD}Deleting NDK $ndk_ver..."
	rm -rf "$ndk_dir"
else
	info "i" "${BOLD}NDK does not exists."
fi

if [ -d "$cmake_dir/3.10.1" ]; then
	log "$cmake_dir/3.10.1 exists. ${BOLD}Deleting cmake..."
	rm -rf "$cmake_dir"
fi

if [ -d "$cmake_dir/3.18.1" ]; then
	log "$cmake_dir/3.18.1 exists. ${BOLD}Deleting cmake..."
	rm -rf "$cmake_dir"
fi

if [ -d "$cmake_dir/3.22.1" ]; then
	echo "$cmake_dir/3.22.1 exists. Deleting cmake..."
	rm -rf "$cmake_dir"
fi

if [ -d "$cmake_dir/3.23.1" ]; then
	log "$cmake_dir/3.23.1 exists. ${BOLD}Deleting cmake..."
	rm -rf "$cmake_dir"
fi

download_ndk "$ndk_file_name" "https://github.com/HomuHomu833/android-ndk-custom/releases/download/$ndk_ver_name/$ndk_file_name"

if [ -f "$ndk_file_name" ]; then
	_info "Unziping NDK $ndk_ver_name..."
    log ""
	tar --no-same-owner -xf "$ndk_file_name" --warning=no-unknown-keyword
	rm $ndk_file_name

	# moving NDK to Android SDK directory
	if [ -d "$ndk_base_dir" ]; then
		mv android-ndk-$ndk_ver_name "$ndk_dir"
	else
		log "${BOLD}NDK base dir does not exists. Creating..."
		mkdir -p "$sdk_dir"/ndk
		mv android-ndk-$ndk_ver_name "$ndk_dir"
	fi

	fix_ndk_musl
    _info "unziping NDK '$ndk_ver_name' finished successfully"
    log ""
else
	log "$ndk_file_name does not exists."
fi

if [ -d "$cmake_dir" ]; then
	cd "$cmake_dir"
	run_install_cmake
else
	mkdir -p "$cmake_dir"
	cd "$cmake_dir"
	run_install_cmake
fi

if [[ $ndk_installed == true && $cmake_installed == true ]]; then
	_success "Installation Finished. NDK has been installed successfully"
else
	_warning "NDK and cmake has been does not installed successfully!"
fi
