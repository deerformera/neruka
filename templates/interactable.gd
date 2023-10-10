extends StaticBody2D

signal interacted
signal uninteracted
signal activated

func _interacted(): $Tag.show()
func _uninteracted(): $Tag.hide()
func _activated(): pass

func _ready():
    self.connect("interacted", self, "_interacted")
    self.connect("uninteracted", self, "_uninteracted")
    self.connect("activated", self, "_activated")
