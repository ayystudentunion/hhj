# https://github.com/jnicklas/capybara/commit/4f805d5a1c42da29ed32ab0371e24add2dc08af1
# There's a lot of the pseudo :contains selector usage in features so this is
# the easiest way to migrate
Capybara.add_selector(:css) do
  xpath { |css| XPath.css(css) }
end
