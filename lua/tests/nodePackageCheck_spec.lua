-- package.path = package.path .. ';/plugins/nodePackageCheck.nvim/?.lua'

describe("nodePackageCheck", function()
	it("trim_string", function()
		local trim_s = require("nodePackageCheck.service").trim_string("hello     world ")
		assert.True(trim_s == "helloworld")
	end)

	it("get_package_latest_version", function()
		local version = require("nodePackageCheck.service").get_package_latest_version("typescript")
		assert.are.equal(version, "4.9.5")
	end)
end)
