extends Item
class_name StackableItem

@export var stack_size : int = 100

func tooltip():
	return super.tooltip() + (
			RichTextBuilder.property_text(tr("STACK_SIZE"),
			RichTextBuilder.color_text(str(stack_size), Palette.yellow)))
