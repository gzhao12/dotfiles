#! /usr/bin/zsh

dim=${FZF_PREVIEW_COLUMNS}x${FZF_PREVIEW_LINES}

mime_type=$(file --mime-type -b "$1")
  case $mime_type in
    inode/directory)
      eza -1 -T -L 1 --color=always --icons=always "$1"
      ;;
    application/json | text/json)
      jq . "$1"
      ;;
    text/markdown | text/x-markdown)
      bat --style=plain --color=always "$1"
      ;;
    image/*)
      chafa -s "$dim" "$1"
      ;;
    text/x-log | application/x-log)
      lnav "$1"
      ;;
    application/pdf)q
      pdftotext "$1" - | less
      ;;
    text/*)
      bat --color=always --style=numbers "$1"
      ;;
    *)
      echo "Preview not available for this file type."
      ;;
  esac
