name = ExecJS.runtime.name
expected = 'Node.js (V8)'

if name != expected
  raise "Your ExecJS runtime is '#{name}' instead of '#{expected}'. Check README."
end
