extends Object

class_name EffectSystemUtils

static func find_all_children(node:Node) -> Array[Node]:
	return node.find_children("*", "", false, false)


static func print_reference(child:Object, parent:Object) -> void:
	print_rich("[color=pink]objects referenced automatically:[/color] \n child: [b]%s[/b] \n %s \n parent [b]%s[/b] \n %s" % [
		child.get("name"),	
		child.get_script().get_path(),
		parent.get("name"),
		parent.get_script().get_path()
	])

static func print_attachment(wrapper:Node, resource:Resource) -> void:
	print_rich("[color=pink]attach resource to wrapper:[/color] \n wrapper: [b]%s[/b] \n %s \n resource: [b]%s[/b]\n %s" % [
		wrapper.name,	
		wrapper.get_script().get_path(),
		resource.get("name"),
		resource.get_script().get_path()
	])

static func check_resource_name_add_if_none(wrapper:Node, resource:Resource, pattern:String = "%s", new_name:String = wrapper.name) -> void:
	if not "name" in resource:
		push_error("resource has no name property")
	if not resource.get("name"):
		resource.set("name", pattern % new_name)
