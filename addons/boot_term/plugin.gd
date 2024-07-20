@tool
extends EditorPlugin

var thread : Thread = Thread.new()

func _enter_tree():
	# Initialization of the plugin goes here.
	var callable = Callable(self, "run_cmd").bind("start cmd")
	thread.start(callable, Thread.PRIORITY_NORMAL)

func run_cmd(command):
	# You can comment out the prints, all they do is tell you that the terminal has opened and debug info
	if OS.get_name() == "Linux":
		print_rich("Opening a terminal for [i]" + OS.get_distribution_name()) # you can comment this out if you want idc
		OS.execute("konsole", []) # You can replace konsole with whatever terminal you use, on next boot / plugin enable it will use that terminal\

	elif OS.get_name() == "Windows":
		print("Opening Command Prompt")
		OS.execute("cmd", ["/c", command])

	else:
		print_rich("[color=red][b][i]Your OS is not currently supported!")
		print_rich("[b]DEBUG INFO")
		print("OS: " + OS.get_name())
		print("OS VARIANT: " + OS.get_distribution_name())
	return

func _exit_tree():
	# Clean-up of the plugin goes here.
	if thread.is_alive():
		thread.wait_to_finish()
