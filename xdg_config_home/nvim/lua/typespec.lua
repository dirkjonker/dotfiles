local util = require("lspconfig.util")

local root_files = {
  "main.tsp"
}

local lspconfig = require 'lspconfig'
local configs = require 'lspconfig.configs'

if not configs.typespec then
  configs.typespec = {
    default_config = {
      cmd = { "tsp-server", "--stdio" },
      filetypes = {
        "typespec",
        "tsp",
      },
      root_dir = util.root_pattern(unpack(root_files)),
      single_file_support = true,
      docs = {
        description = [[
  https://github.com/microsoft/typespec

  TypeSpec is a language for describing cloud service APIs and generating other API description languages, client and service code, documentation, and other assets. TypeSpec provides highly extensible core language primitives that can describe API shapes common among REST, OpenAPI, GraphQL, gRPC, and other protocols.

  Install:
  npm install -g @typespec/compiler
  ]],
      }
    }
  }
end
