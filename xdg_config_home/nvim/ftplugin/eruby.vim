set ts=2 sts=2 sw=2 et

if &ft == "eruby"
  let b:ale_fixers = ["erblint", {buffer -> {"command": "bundle exec htmlbeautifier %t", "read_temporary_file": 1}}]
endif
