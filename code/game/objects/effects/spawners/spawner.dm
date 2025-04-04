/// An obj that creates other stuff in its loc and then deletes itself
/obj/spawner/simple
	abstract_type = /obj/spawner/simple

	/// A path to spawn one of, or a map of (path = count) to spawn count of each path of
	var/to_spawn


/obj/spawner/simple/Initialize()
	SHOULD_CALL_PARENT(FALSE)
	SHOULD_NOT_OVERRIDE(TRUE)
	atom_flags |= ATOM_FLAG_INITIALIZED
	if (ispath(to_spawn))
		new to_spawn (loc)
	else if (islist(to_spawn))
		for (var/path in to_spawn)
			for (var/count in 1 to to_spawn[path])
				new path (loc)
	return INITIALIZE_HINT_QDEL
