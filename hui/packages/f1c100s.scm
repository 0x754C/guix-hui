(define-module (hui packages f1c100s)
  #:use-module (gnu packages)
  #:use-module (gnu packages bootloaders)
  #:use-module (gnu packages linux)
  #:use-module (gnu packages tls)
  #:use-module (guix packages)
  #:use-module (guix gexp)
  #:use-module (guix utils)
  #:use-module (guix git-download)
  #:use-module ((guix licenses) #:prefix licenses:)
  #:use-module (guix download))

(define-public u-boot-licheepi-nano
  (let* ((u-boot (make-u-boot-package "licheepi_nano" "arm-linux-gnueabihf")))
    (package
    (inherit u-boot)
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/u-boot/u-boot.git")
             (commit "5dcfc99b2b17fa1497adea47a50bf7c7a6ba5709")))
       (sha256
        (base32
         "09xf0n2qj8h9ay9lq6ajq1zvq4k2iv243jjhw0yi3bkkvkwcbmv6"))
       (patches
        (append
         (origin-patches (package-source u-boot))
         (list
          (local-file "aux-files/u-boot-f1c100s/0001-arch-arm-mach-sunxi-board.c-force-suniv-boot-from-sp.patch")
          (local-file "aux-files/u-boot-f1c100s/0002-drivers-phy-allwinner-phy-sun4i-usb.c-add-suniv_f1c1.patch")
          (local-file "aux-files/u-boot-f1c100s/0003-drivers-usb-musb-new-sunxi.c-add-suniv-f1c100s-musb-.patch")
          (local-file "aux-files/u-boot-f1c100s/0004-board-sunxi-board.c-add-usb-gadget-initial-at-bootup.patch")
          (local-file "aux-files/u-boot-f1c100s/0005-drivers-pinctrl-sunxi-pinctrl-sunxi.c-add-spi1-funct.patch")
          (local-file "aux-files/u-boot-f1c100s/0006-arch-arm-dts-suniv-f1c100s-licheepi-nano.dts-change-.patch")
          (local-file "aux-files/u-boot-f1c100s/0007-configs-licheepi_nano_defconfig-enable-usb-gadget-us.patch")
          (local-file "aux-files/u-boot-f1c100s/0008-configs-licheepi_nano_defconfig-store-env-data-in-sp.patch")))))))))

(define-public linux-allwinner-f1c100s
  (package
    (inherit
     (customize-linux
      #:name "linux-allwinner-f1c100s"
      #:linux linux-libre-arm-generic
      #:source
      (origin
        (method git-fetch)
        (uri (git-reference
              (url "https://github.com/torvalds/linux")
              (commit "a785fd28d31f76d50004712b6e0b409d5a8239d8")))
        (sha256
         (base32
          "15vxpgp40sf06gwl845jd25mpi6mxnj3fd5vkpm5pgs481b7s6xb"))
        (patches
         (list
          (local-file "aux-files/linux-f1c100s/0001-arch-arm-boot-dts-allwinner-suniv-f1c100s-licheepi-n.patch")
          (local-file "aux-files/linux-f1c100s/0002-arch-arm-configs-allwinner_f1c100s_defconfig-add-con.patch"))))
      #:defconfig "allwinner_f1c100s_defconfig"))
    (version "6.5.0-rc5")))

