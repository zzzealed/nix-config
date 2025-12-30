{
	alsa-lib,
	autoPatchelfHook,
	fetchurl,
	ffmpeg_7,
	gtk3,
	lib,
	libGL,
	libX11,
	patchelfUnstable,
	pipewire,
	stdenv,
	wrapGAppsHook3,
	makeDesktopItem
}:
stdenv.mkDerivation rec {
	name = "glide-bin-${version}";
	version = "0.1.56a";
	src = fetchurl {
		url = "https://github.com/glide-browser/glide/releases/download/${version}/glide.linux-x86_64.tar.xz";
		sha256 = "f6fe3d0c23d181a25ecae4e4221de1a1e7646ce84a467023fec77feea40a432c";
	};
	sourceRoot = ".";
	unpackCmd = "tar -xvf $src";

	nativeBuildInputs = [
		autoPatchelfHook
		patchelfUnstable
		wrapGAppsHook3
	];

	buildInputs = [
		alsa-lib
		gtk3
		libX11
	];

	appendRunpaths = [ "${pipewire}/lib" "${libGL}/lib" ];

	patchelfFlags = [ "--no-clobber-old-sections" ];

	# Codec support
	preFixup = ''
		gappsWrapperArgs+=(
				--prefix LD_LIBRARY_PATH : "${lib.makeLibraryPath [ffmpeg_7]}"
			)
	'';

	installPhase = ''
		runHook preInstall

		mkdir -p $out/bin $out/share/icons/hicolor/128x128/apps $out/share/applications
		cp -R glide $out
		ln -s $out/glide/glide-bin $out/bin/glide
		cp glide/browser/chrome/icons/default/default128.png $out/share/icons/hicolor/128x128/apps/glide.png
		cp ${desktopEntry}/share/applications/glide-bin.desktop $out/share/applications/glide.desktop

		runHook postInstall
	'';

	desktopEntry = makeDesktopItem {
		name = "glide-bin";
		exec = "glide --name glide %U";
		icon = "glide";
		desktopName = "Glide";
		genericName = "Web Browser";
		terminal = false;
		startupNotify = true;
		startupWMClass = "glide-browser";
		categories = [
			"Network"
			"WebBrowser"
		];
		mimeTypes = [
			"text/html"
			"text/xml"
			"application/xhtml+xml"
			"application/vnd.mozilla.xul+xml"
			"x-scheme-handler/http"
			"x-scheme-handler/https"
		];
	};

	meta = with lib; {
		description = "An extensible and keyboard-focused web browser.";
		homepage = "https://glide-browser.app";
		license = licenses.mpl20;
		maintainers = [ "45Hnri" ];
		platforms = platforms.linux;
	};
}
