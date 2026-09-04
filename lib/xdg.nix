{ config, pkgs, pkgs23, ... }: {

  xdg.mime.defaultApplications = {
    "inode/directory" = "thunar.desktop";

    # browser
    "text/html" = "google-chrome.desktop";
    "x-scheme-handler/https" = "google-chrome.desktop";
    "x-scheme-handler/about" = "google-chrome.desktop";
    "x-scheme-handler/unknown" = "google-chrome.desktop";

    # text 
    "text/plain" = "neovide.desktop";
    "text/markdown" = "neovide.desktop";

    # pdf/epub
    "application/pdf" = "okularApplication_pdf.desktop";
    "application/epub+zip" = "calibre-gui.desktop";

    # telegram
    "x-scheme-handler/tg" = "org.telegram.desktop.desktop";
    "x-scheme-handler/tonsite" = "org.telegram.desktop.desktop";
    "image/svg+xml" = "nvim.desktop";

    # Videos (mpv)
    "video/mp4" = "mpv.desktop";
    "video/x-matroska" = "mpv.desktop";
    "video/webm" = "mpv.desktop";
    "video/avi" = "mpv.desktop";
    "video/quicktime" = "mpv.desktop";
    "video/x-flv" = "mpv.desktop";

    # Images (Ristretto)
    "image/jpeg" = "org.xfce.ristretto.desktop";
    "image/png" = "org.xfce.ristretto.desktop";
    "image/gif" = "org.xfce.ristretto.desktop";
    "image/webp" = "org.xfce.ristretto.desktop";
    "image/bmp" = "org.xfce.ristretto.desktop";
    "image/tiff" = "org.xfce.ristretto.desktop";

    # Office Files (LibreOffice)
    "application/vnd.openxmlformats-officedocument.wordprocessingml.document" =
      "writer.desktop";
    "application/msword" = "writer.desktop";
    "application/vnd.oasis.opendocument.text" = "writer.desktop";
    "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" =
      "calc.desktop";
    "application/vnd.ms-excel" = "calc.desktop";
    "application/vnd.oasis.opendocument.spreadsheet" = "calc.desktop";
    "application/vnd.openxmlformats-officedocument.presentationml.presentation" =
      "impress.desktop";
    "application/vnd.ms-powerpoint" = "impress.desktop";
    "application/vnd.oasis.opendocument.presentation" = "impress.desktop";
  };

  xdg.mime.enable = true;
}
