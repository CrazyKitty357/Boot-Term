@tool
extends EditorPlugin

var thread : Thread = Thread.new()

func _enter_tree():
	# Initialization of the plugin goes here.
	var callable = Callable(self, "run_cmd").bind("start cmd")
	thread.start(callable, Thread.PRIORITY_NORMAL)

func run_cmd(command):
	OS.execute("cmd", ["/c", command])
	return


func _exit_tree():
	# Clean-up of the plugin goes here.
		if thread.is_alive():
			thread.wait_to_finish()
