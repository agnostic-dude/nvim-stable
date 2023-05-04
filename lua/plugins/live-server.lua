local status_ok, live_server = pcall(require, "live_server")
if not status_ok then
  vim.notify("live-server is not installed", WARN, { title = "Live-server Config" })
  return 1
end

live_server.setup({
  port = 8080,
  browser_command = "/usr/bin/google-chrome-stable %U",
  quiet = false,
  no_css_inject = false, -- if true disable CSS injection, useful when testing tailwindcss
  install_path = vim.fn.stdpath("data") .. "/live-server/",
})
