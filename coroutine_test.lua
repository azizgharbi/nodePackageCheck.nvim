Hello = coroutine.create(function(ps)
	for _, p in ipairs(ps) do
		local url = "https://registry.npmjs.org/" .. p .. "/latest"
		local cmd = "curl -s '" .. url .. '\' | grep -Po \'(?<="version":")[^"]*\''
		local handle = io.popen(cmd)
		if handle then
			local version = handle:read("*line")
			handle:close()
			if version ~= nil then
				coroutine.yield(version)
			end
		end
	end
end)

local ps = { "react", "vue", "angular" }
for i = 1, 3, 1 do
	print(i)
	print(coroutine.resume(Hello, ps))
	print("done")
end
