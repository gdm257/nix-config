{
  inputs,
  outputs,
  globals,
  lib,
  config,
  pkgs,
  ...
}: {
  editorconfig = {
    enable = true;
    settings = {
      "*" = {
        charset = "utf-8";
        end_of_line=  "lf";
        trim_trailing_whitespace = true;
        indent_style = "space";
        # indent_size= 4;
        # insert_final_newline = true;
      };
    };
  };
}
