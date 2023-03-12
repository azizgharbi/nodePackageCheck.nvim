-- package.path = package.path .. ';/plugins/nodePackageCheck.nvim/?.lua'

local npc = require("nodePackageCheck")

describe("nodePackageCheck", function()
	it("trim_string", function()
		local trim_s = npc.utils.trim_string("hello     world ")
		assert.True(trim_s == "helloworld")
	end)

	it("get_package_latest_version", function()
		local version = npc.utils.get_package_latest_version("typescript")
		assert.are.equal(version, "4.9.5")
	end)
end)
