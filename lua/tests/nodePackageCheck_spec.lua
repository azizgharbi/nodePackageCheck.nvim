-- package.path = package.path .. ';/plugins/nodePackageCheck.nvim/?.lua'

local npc = require("nodePackageCheck")

describe("nodePackageCheck", function()
	it("get_package_latest_version", function()
		local version = npc.utils.get_package_latest_version("typescript")
		assert.are.equal(version, '"4.9.5"')
	end)
end)
