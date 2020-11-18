extends Node

var core: ConfigFile

var where: String

func _init():
	core = ConfigFile.new()
	print("MOONSHOT Simulator And Control System")
	print("An Ascent Technologies Product")
	print("This program contains third-party software under various open-source licenses.")
	print("Please see the Credits screen for details.")
	print("")
	print("Loading user license state...")
	where = "user://ascent.lic"
	if OS.has_feature("standalone"):
		print(" CONSULTANT: Consultant of Ascent Technologies")
		print(" License state will be stored in executable directory")
		var basedir = OS.get_executable_path().get_base_dir()
		where = basedir + "/ascent.lic"
	else:
		print(" DEVELOPER: Ascent Technologies simulation developer")
		print(" License state will be stored in project directory")
		where = "ascent.lic"
	print("Final decision on data location: " + where)
	core.load(where)
	core.set_value("meta", "employee_id", 20201105)
	if not core.has_section_key("meta", "license_granted_on"):
		core.set_value("meta", "license_granted_on", OS.get_unix_time())
		core.set_value("meta", "was_consultant", false)
		core.set_value("meta", "was_developer", false)
	if OS.has_feature("standalone"):
		if core.get_value("meta", "developer", false):
			core.set_value("flags", "developer", true)
			# this indicates the user has cheated
			core.set_value("flags", "maiq", true)
		core.set_value("meta", "developer", false)
		core.set_value("meta", "was_consultant", true)
	else:
		core.set_value("flags", "developer", true)
		core.set_value("meta", "developer", true)
		core.set_value("meta", "was_developer", true)
	core.set_value("meta", "license_notes", "Just trust me, licensing this person with the software will pay dividends in the long run. - Joanna Ipcrus")
	if not core.has_section_key("flags", "basic_simulation_services"):
		# DEFAULT FLAGS GO HERE
		core.set_value("flags", "basic_simulation_services", true)
		core.set_value("flags", "ui_sounds", true)
		core.set_value("flags", "music", true)
	core.set_value("savestates", "template", "")
	core.set_value("solutions", "template", "")
	core.set_value("checksum", "notes", "Honestly, do you actually think you're supposed to look at this file? I mean, you *can*. I'm not going to stop you.")
	print("Are we allowed to save data? " + str(flag_get("gdpr")))

func flag_set(flag):
	if not flag_get(flag):
		# print("(flag) set " + flag)
		core.set_value("flags", flag, true)
		save_flags()

func flag_set_nosave(flag):
	if not flag_get(flag):
		# print("(flag) setns " + flag)
		core.set_value("flags", flag, true)

func flag_unset(flag):
	if flag_get(flag):
		# print("(flag) unset " + flag)
		core.set_value("flags", flag, false)
		save_flags()

func flag_clear():
	core.erase_section("flags")
	save_flags()

func flag_get(flag):
	return core.get_value("flags", flag, false)

func save_flags():
	thunk_video()
	if not flag_get("gdpr"):
		print("Refused to save flags without passing GDPR compliance check.")
		return
	core.save(where)

func thunk_video():
	OS.window_fullscreen = flag_get("fullscreen")
	var mus = AudioServer.get_bus_index("Music")
	if flag_get("music"):
		AudioServer.set_bus_volume_db(mus, linear2db(1.0))
	else:
		AudioServer.set_bus_volume_db(mus, linear2db(0.0))
