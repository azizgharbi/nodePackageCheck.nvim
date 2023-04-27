local Messages = {}

-- Messages
Messages.ERROR_MESSAGES = {
	WRONG_FILE = "Error: please use this command in a package.json file",
	NO_PACKAGE = "This line doesn't contain any package",
	PACKAGE_NOT_FOUND = "The package is not found",
	MISSING_PACKAGE_NAME = "Error: please provide the package name",
	SOMETHING_WRONG = "Error: something wrong",
}

Messages.INFO_MESSAGES = {
	GOOD_VERSION = "Info: You are using already the latest version",
	QUESTION = "DO you want to update this package version [Y/N]: ",
}
-- END

return Messages
