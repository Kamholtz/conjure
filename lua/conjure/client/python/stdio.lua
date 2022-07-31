local _2afile_2a = "fnl/conjure/client/python/stdio.fnl"
local _2amodule_name_2a = "conjure.client.python.stdio"
local _2amodule_2a
do
  package.loaded[_2amodule_name_2a] = {}
  _2amodule_2a = package.loaded[_2amodule_name_2a]
end
local _2amodule_locals_2a
do
  _2amodule_2a["aniseed/locals"] = {}
  _2amodule_locals_2a = (_2amodule_2a)["aniseed/locals"]
end
local autoload = (require("conjure.aniseed.autoload")).autoload
local a, client, config, extract, f, ll, log, mapping, nvim, stdio, str, text, ts, ts_util, _ = autoload("conjure.aniseed.core"), autoload("conjure.client"), autoload("conjure.config"), autoload("conjure.extract"), autoload("fennel"), autoload("conjure.linked-list"), autoload("conjure.log"), autoload("conjure.mapping"), autoload("conjure.aniseed.nvim"), autoload("conjure.remote.stdio"), autoload("conjure.aniseed.string"), autoload("conjure.text"), autoload("conjure.tree-sitter"), autoload("nvim-treesitter.ts_utils"), nil
_2amodule_locals_2a["a"] = a
_2amodule_locals_2a["client"] = client
_2amodule_locals_2a["config"] = config
_2amodule_locals_2a["extract"] = extract
_2amodule_locals_2a["f"] = f
_2amodule_locals_2a["ll"] = ll
_2amodule_locals_2a["log"] = log
_2amodule_locals_2a["mapping"] = mapping
_2amodule_locals_2a["nvim"] = nvim
_2amodule_locals_2a["stdio"] = stdio
_2amodule_locals_2a["str"] = str
_2amodule_locals_2a["text"] = text
_2amodule_locals_2a["ts"] = ts
_2amodule_locals_2a["ts_util"] = ts_util
_2amodule_locals_2a["_"] = _
--[[ vim.g.conjure#filetype#clojure vim.g.conjure#filetypes (set vim.g.conjure#debug false) (set vim.g.conjure#debug true) (dbgn {:a "aa"} {:debug? true}) (dbgn (+ 1 2 3) {:debug? true}) (dbgn (defn aaa {} (+ 1 2)) {:debug? false}) (aaa) ]]--
local function insert_history(item)
  if not _G["g-msg"] then
    __fnl_global__g_2dmsg = {}
  else
  end
  return table.insert(__fnl_global__g_2dmsg, item)
end
_2amodule_2a["insert-history"] = insert_history
local function clear_history()
  __fnl_global__g_2dmsg = {}
  return nil
end
_2amodule_2a["clear-history"] = clear_history
local function last_history()
  return a.last(__fnl_global__g_2dmsg)
end
_2amodule_2a["last-history"] = last_history
vim.g["conjure#filetype#python"] = "config.plugin.conjure-python"
vim.g["conjure#filetypes"] = {"clojure", "fennel", "janet", "hy", "racket", "scheme", "lua", "lisp", "python"}
local input_prompt_pattern = "In %[%d+%]: "
--[[ (string.find "IPython search prompt: In [123]: " input-prompt-pattern) ]]--
config.merge({client = {python = {stdio = {mapping = {start = "cs", stop = "cS", interrupt = "ei"}, command = "python3 -m IPython", prompt_pattern = input_prompt_pattern}}}}, {["overwrite?"] = true})
local cfg = config["get-in-fn"]({"client", "python", "stdio"})
do end (_2amodule_locals_2a)["cfg"] = cfg
local state
local function _2_()
  return {repl = nil}
end
state = ((_2amodule_2a).state or client["new-state"](_2_))
do end (_2amodule_locals_2a)["state"] = state
local function send_to_repl(code)
  local function _3_(repl)
    local function _4_(msg)
      return log.dbg("msg", msg)
    end
    return repl.send(__fnl_global__prep_2dcode_2d2(code), _4_)
  end
  return __fnl_global__with_2drepl_2dor_2dwarn(_3_)
end
_2amodule_2a["send-to-repl"] = send_to_repl
local test_fn_str_1 = "\ndef bb():\n    def inner_cc():\n        print('inside cc3')\n  \n    inner_cc()\n\n    print('inside bb3')\n\n    return 'RESULT OF BB()'\n"
local test_fn_str_2 = "def cc():\n    print('inside cc 1')\n\n    print('inside cc 2')\n    return 'cc'"
--[[ (do (stop) (start)) (log.dbg "msg" "frog" "egg") (do (send-to-repl "print('hi')")) (do "... ... ... ..." (send-to-repl test-fn-str-1)) (do (send-to-repl test-fn-str-2)) (do (send-to-repl "cc()")) (do (send-to-repl "(1 + 2 + 3)")) ]]--
local buf_suffix = ".py"
_2amodule_2a["buf-suffix"] = buf_suffix
local comment_prefix = "# "
_2amodule_2a["comment-prefix"] = comment_prefix
--[[ (last-node:sexpr) (last-node:type) (last-node:start) (let [(row col byte-count) (last-node:start)] (cdbgn [row col byte-count])) (last-node:end_) (last-node:has_error) (last-node:child_count) (last-node:child (- (last-node:named_child_count) 1)) (node->has-return-statement last-node 5) ]]--
--[[ (cdbgn {:aa (+ 1 2)}) g-msg (clear-history) (last-history) (: g-msg 2 "node" "sexpr") (: (. g-msg 2 "node") "sexpr") (global last-node (. g-msg 2 "node")) ]]--
local function parser__3eroot(parser)
  return (parser:parse()[1]):root()
end
_2amodule_2a["parser->root"] = parser__3eroot
local function get_bufnr()
  return vim.api.nvim_get_current_buf()
end
_2amodule_2a["get-bufnr"] = get_bufnr
do
  local function node__3ehas_return_statement(node, bufnr)
    local f0 = require("fennel")
    local vts = vim.treesitter
    local q = vim.treesitter.query
    local parser = vts.get_parser(bufnr, "python")
    local root = parser__3eroot(parser)
    local query = "(return_statement) @blockWithReturnStatement"
    local parsed_query = vts.parse_query("python", query)
    local start_row, _0, _1 = node:start()
    local end_row, _2, _3 = node:end_()
    local res = parsed_query:iter_matches(node, bufnr, start_row, (end_row + 1))
    __fnl_global__iter_2dmatches_2dres = res
    local return_statement_count = 0
    for id, m, metadata in res do
      if (#m > 0) then
        return_statement_count = (1 + return_statement_count)
      else
      end
    end
    insert_history({node = node, ["iter-matches"] = res, ["return-statement-count"] = return_statement_count})
    return (return_statement_count ~= 0)
  end
  _2amodule_2a["node->has-return-statement"] = node__3ehas_return_statement
  local function python_node_3f(node, extra_pairs)
    print("python node: \n", ts["node->str"](node))
    __fnl_global__last_2dnode = node
    log.dbg("sexpr:", node:sexpr())
    log.dbg("buffer #: ", get_bufnr())
    local _6_ = node:type()
    if (_6_ == "block") then
      return not node__3ehas_return_statement(node, get_bufnr())
    elseif (_6_ == "elif_clause") then
      return false
    elseif (_6_ == "else_clause") then
      return false
    elseif (_6_ == "return_statement") then
      return false
    elseif (_6_ == "attribute") then
      return false
    elseif (_6_ == "call") then
      return true
    elseif (_6_ == "aliased_import") then
      return false
    elseif (_6_ == "dotted_name") then
      return false
    elseif (_6_ == "import_statement") then
      return true
    elseif true then
      local _0 = _6_
      return true
    else
      return nil
    end
  end
  _2amodule_2a["python-node?"] = python_node_3f
  local form_node_3f = python_node_3f
  _2amodule_2a["form-node?"] = form_node_3f
end
local function with_repl_or_warn(f0, opts)
  local repl = state("repl")
  if repl then
    return f0(repl)
  else
    return log.append({(comment_prefix .. "No REPL running"), (comment_prefix .. "Start REPL with " .. config["get-in"]({"mapping", "prefix"}) .. cfg({"mapping", "start"}))})
  end
end
_2amodule_locals_2a["with-repl-or-warn"] = with_repl_or_warn
local prompt_pattern = "[ ]+...: "
local prompt_pattern_start = ("^" .. prompt_pattern .. "[\13]*[\n]*")
local function replace_prompt(line, has_replaced_once_3f)
  local res = string.gsub(line, prompt_pattern_start, "")
  if (#line == #res) then
    if (has_replaced_once_3f and (#res == 0)) then
      return nil
    else
      return res
    end
  else
    return replace_prompt(res, true)
  end
end
_2amodule_2a["replace-prompt"] = replace_prompt
local function print_and_return(...)
  log.dbg(...)
  return ...
end
_2amodule_2a["print-and-return"] = print_and_return
local function create_iter(seq)
  return {curr = 0, seq = seq}
end
_2amodule_2a["create-iter"] = create_iter
local function has_next(_11_)
  local _arg_12_ = _11_
  local curr = _arg_12_["curr"]
  local seq = _arg_12_["seq"]
  local iter = _arg_12_
  return seq[(curr + 1)]
end
_2amodule_2a["has-next"] = has_next
local function next(_13_)
  local _arg_14_ = _13_
  local curr = _arg_14_["curr"]
  local seq = _arg_14_["seq"]
  local iter = _arg_14_
  iter["curr"] = (curr + 1)
  return seq[iter.curr]
end
_2amodule_2a["next"] = next
local function peek_prev(_15_)
  local _arg_16_ = _15_
  local curr = _arg_16_["curr"]
  local seq = _arg_16_["seq"]
  local iter = _arg_16_
  return seq[(curr - 1)]
end
_2amodule_2a["peek-prev"] = peek_prev
local function peek(_17_)
  local _arg_18_ = _17_
  local curr = _arg_18_["curr"]
  local seq = _arg_18_["seq"]
  local iter = _arg_18_
  return seq[(curr + 1)]
end
_2amodule_2a["peek"] = peek
local function is_prompt(line)
  return string.find(line, prompt_pattern_start)
end
_2amodule_2a["is-prompt"] = is_prompt
local function set_result_and_can_drop(c, p, n)
  local new_meta
  local _20_
  do
    local t_19_ = p
    if (nil ~= t_19_) then
      t_19_ = (t_19_)["can-drop"]
    else
    end
    _20_ = t_19_
  end
  if (c["is-blank"] and (a["nil?"](n) or not _20_)) then
    new_meta = {["can-drop"] = true}
  else
    if c["is-prompt"] then
      new_meta = {result = replace_prompt(c.line)}
    else
      if n then
        if (c["is-blank"] and n["is-prompt"]) then
          new_meta = {["can-drop"] = true}
        else
          new_meta = {result = c.line}
        end
      else
        new_meta = {result = c.line}
      end
    end
  end
  return a["merge!"](c, new_meta)
end
_2amodule_2a["set-result-and-can-drop"] = set_result_and_can_drop
local function set_is_prompt(_26_)
  local _arg_27_ = _26_
  local line = _arg_27_["line"]
  local t = _arg_27_
  local is_prompt0 = is_prompt(line)
  return a.assoc(t, "is-prompt", is_prompt0)
end
local function set_is_blank(_28_)
  local _arg_29_ = _28_
  local line = _arg_29_["line"]
  local t = _arg_29_
  local is_blank = (#line == 0)
  return a.assoc(t, "is-blank", is_blank)
end
local function lines__3elog(lines)
  local meta
  local function _30_(_241)
    return a.assoc({}, "line", _241)
  end
  meta = a.map(set_is_blank, a.map(set_is_prompt, a.map(_30_, lines)))
  local iter = create_iter(meta)
  local res = {}
  while has_next(iter) do
    table.insert(res, set_result_and_can_drop(next(iter), peek_prev(iter), peek(iter)))
  end
  local function _31_(_241)
    return (_241).result
  end
  return a.map(_31_, res)
end
_2amodule_2a["lines->log"] = lines__3elog
local function format_display(full_msg)
  return lines__3elog(str.split(full_msg, "\13\n"))
end
_2amodule_2a["format-display"] = format_display
local function display_result(msg)
  local prefix
  local function _32_()
    if msg.err then
      return "(err)"
    else
      return "(out)"
    end
  end
  prefix = (comment_prefix .. _32_() .. " ")
  local function _33_(_241)
    return (prefix .. _241)
  end
  return log.append(a.map(_33_, format_display((msg.err or msg.out))))
end
_2amodule_locals_2a["display-result"] = display_result
local full_test_str = "first\13\n\13\n   ...:    ...:    ...:    ...:    ...:    ...:    ...:    ...:    ...:    ...:    ...: aa->bb->elif\13\nOut[2]: 'aa->return'\13\n\13\n   ...:    ...: ->if\13\nOut[3]: 6\13\n\13\n   ...:    ...: \13\n"
do
  lines__3elog(str.split(full_test_str, "\13\n"))
  set_is_prompt({line = "   ...: "})
  set_is_blank({line = "aa"})
  local function _34_(_241)
    return a.assoc({}, "line", _241)
  end
  a.map(set_is_blank, a.map(set_is_prompt, a.map(_34_, str.split(full_test_str, "\13\n"))))
end
--[[ (do (lines->log (str.split full-test-str "\r
"))) ]]--
local function replace_blank_lines(str_in)
  local function _35_(_241)
    return not str["blank?"](_241)
  end
  return str.join("\n", a.filter(_35_, str.split(str_in, "\n")))
end
_2amodule_2a["replace-blank-lines"] = replace_blank_lines
--[[ (replace-blank-lines test-fn-str-1) ]]--
local function add_whitespace(code, num_ws)
  local ii = num_ws
  local code_with_ws = code
  while (ii > 0) do
    code_with_ws = (" " .. code_with_ws)
    ii = a.dec(ii)
  end
  return code_with_ws
end
_2amodule_2a["add-whitespace"] = add_whitespace
local function prep_code_2(code, range, is_std_python)
  local function trim_code_left(code0, num_left)
    local s_col = (num_left + 1)
    local lines = str.split(code0, "\n")
    local trimmed_lines
    local function _36_(_241)
      return string.sub(_241, s_col, -1)
    end
    trimmed_lines = a.map(_36_, lines)
    return str.join("\n", trimmed_lines)
  end
  _2amodule_2a["trim-code-left"] = trim_code_left
  local function get_code_metadata(code0)
    local lines = str.split(code0, "\n")
    local indents
    local function _37_(line)
      return (string.len(line) - string.len(str.triml(line)))
    end
    indents = a.map(_37_, lines)
    local non_zero_indents
    local function _38_(_241)
      return (_241 > 0)
    end
    non_zero_indents = a.filter(_38_, indents)
    local min_indent
    if (#non_zero_indents == 0) then
      min_indent = 0
    else
      local function _39_(_241, _242)
        return math.min(_241, _242)
      end
      min_indent = a.reduce(_39_, non_zero_indents[1], non_zero_indents)
    end
    local final_indent = indents[#indents]
    return {["num-lines"] = #indents, ["min-indent"] = min_indent, ["final-indent"] = final_indent}
  end
  _2amodule_2a["get-code-metadata"] = get_code_metadata
  local function add_final_newlines(code0, _41_)
    local _arg_42_ = _41_
    local min_indent = _arg_42_["min-indent"]
    local final_indent = _arg_42_["final-indent"]
    local level_of_indentation
    if ((min_indent ~= 0) and (final_indent ~= 0)) then
      level_of_indentation = (final_indent / min_indent)
    else
      level_of_indentation = 0
    end
    local num_newlines = (1 + level_of_indentation)
    local function append_newline(code1, num_newlines0)
      if (0 == num_newlines0) then
        return code1
      else
        return append_newline((code1 .. "\n"), a.dec(num_newlines0))
      end
    end
    return append_newline(code0, num_newlines)
  end
  _2amodule_2a["add-final-newlines"] = add_final_newlines
  local s_col
  local function _45_()
    local t_46_ = range
    if (nil ~= t_46_) then
      t_46_ = (t_46_).start
    else
    end
    if (nil ~= t_46_) then
      t_46_ = (t_46_)[2]
    else
    end
    return t_46_
  end
  s_col = (_45_() or 0)
  local fmt_code = replace_blank_lines(code)
  local fmt_code_1 = add_whitespace(fmt_code, s_col)
  local fmt_code_2 = trim_code_left(fmt_code_1, s_col)
  local code_metadata = get_code_metadata(fmt_code_2)
  if is_std_python then
    return add_final_newlines(fmt_code_2, code_metadata)
  else
    local function _49_()
      if (code_metadata["final-indent"] == 0) then
        return "\n"
      else
        return "\n\n"
      end
    end
    return (fmt_code_2 .. _49_())
  end
end
_2amodule_2a["prep-code-2"] = prep_code_2
--[[ (clear-history) (last-history) g-msg ]]--
local function eval_str(opts)
  local last_value = nil
  local function _51_(repl)
    local sent
    local function _53_()
      local t_52_ = opts
      if (nil ~= t_52_) then
        t_52_ = (t_52_).range
      else
      end
      return t_52_
    end
    sent = prep_code_2(opts.code, _53_())
    local function _55_(msg)
      log.dbg("MSG", msg)
      do
        local msgs = format_display((msg.err or msg.out))
        last_value = (a.last(msgs) or last_value)
        display_result(msg)
        if msg["done?"] then
          log.append({""})
          if opts["on-result"] then
            opts["on-result"](last_value)
          else
          end
        else
        end
      end
      return {["batch?"] = true}
    end
    return repl.send(sent, _55_)
  end
  return with_repl_or_warn(_51_)
end
_2amodule_2a["eval-str"] = eval_str
local function eval_file(opts)
  return eval_str(a.assoc(opts, "code", a.slurp(opts["file-path"])))
end
_2amodule_2a["eval-file"] = eval_file
local function display_repl_status(status)
  local repl = state("repl")
  if repl then
    return log.append({(comment_prefix .. a["pr-str"](a["get-in"](repl, {"opts", "cmd"})) .. " (" .. status .. ")")}, {["break?"] = true})
  else
    return nil
  end
end
_2amodule_locals_2a["display-repl-status"] = display_repl_status
local function stop()
  local repl = state("repl")
  if repl then
    repl.destroy()
    display_repl_status("stopped")
    return a.assoc(state(), "repl", nil)
  else
    return nil
  end
end
_2amodule_2a["stop"] = stop
local function start()
  if state("repl") then
    return log.append({(comment_prefix .. "Can't start, REPL is already running."), (comment_prefix .. "Stop the REPL with " .. config["get-in"]({"mapping", "prefix"}) .. cfg({"mapping", "stop"}))}, {["break?"] = true})
  else
    local function _60_()
      display_repl_status("started")
      local function _61_(repl)
        print(repl)
        return repl.send(prep_code_2("print('You just connected to the IPython REPL with Conjure!')"))
      end
      return with_repl_or_warn(_61_)
    end
    local function _62_(err)
      return display_repl_status(err)
    end
    local function _63_(code, signal)
      if (("number" == type(code)) and (code > 0)) then
        log.append({(comment_prefix .. "process exited with code " .. code)})
      else
      end
      if (("number" == type(signal)) and (signal > 0)) then
        log.append({(comment_prefix .. "process exited with signal " .. signal)})
      else
      end
      return stop()
    end
    local function _66_(msg)
      print(msg)
      return display_result(msg)
    end
    return a.assoc(state(), "repl", stdio.start({["prompt-pattern"] = cfg({"prompt_pattern"}), cmd = cfg({"command"}), ["on-success"] = _60_, ["on-error"] = _62_, ["on-exit"] = _63_, ["on-stray-output"] = _66_}))
  end
end
_2amodule_2a["start"] = start
local function on_load()
  return start()
end
_2amodule_2a["on-load"] = on_load
local function on_exit()
  return stop()
end
_2amodule_2a["on-exit"] = on_exit
local function interrupt()
  log.dbg("sending interrupt message", "")
  local function _68_(repl)
    local uv = vim.loop
    return uv.kill(repl.pid, uv.constants.SIGINT)
  end
  return with_repl_or_warn(_68_)
end
_2amodule_2a["interrupt"] = interrupt
local function on_filetype()
  mapping.buf("n", "PythonStart", cfg({"mapping", "start"}), _2amodule_name_2a, "start")
  mapping.buf("n", "PythonStop", cfg({"mapping", "stop"}), _2amodule_name_2a, "stop")
  return mapping.buf("n", "PythonInterrupt", cfg({"mapping", "interrupt"}), _2amodule_name_2a, "interrupt")
end
_2amodule_2a["on-filetype"] = on_filetype
return _2amodule_2a