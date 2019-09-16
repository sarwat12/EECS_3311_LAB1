note
	description: "A priority queue of tasks."
	author: "Jackie and You"
	date: "$Date$"
	revision: "$Revision$"

class
	SCHEDULER[TASK] 	-- TASK a generic type parameter, which may be instantiated
									-- by a client of SCHEDULER as any type (e.g., STRING).
									-- Use TASK to refer to the type that will be instantiated by the client.

create
	-- Select command `make_from_array` to be the only constructor of the current class.
	make_from_array

feature {ES_TEST} -- Implementation
	-- Do not modify this section. Your implementation should update these two attributes properly.

	tasks: HASH_TABLE[TASK, INTEGER]
		-- A map from a priority value to a task object of type TASK.
		-- Note. The first parameter TASK refers to the type of values, whereas
		-- the second parameter INTEGER refers to the type of keys in the table.

	pq: ARRAYED_HEAP
		-- A priority queue implemented using the array-represented heap.
		-- Question: who's the client? who's the supplier?

feature -- Constructors

	make_from_array (new_tasks: ARRAY[TUPLE[task: TASK; priority: INTEGER]]; n: INTEGER)
			-- Create a scheduler with an empty set of tasks.
			-- Note. Tuples are like records with various named fields (i.e., task, priority).
			-- You may access a field in a tuple using the dot notation: e.g., new_tasks[1].task, new_tasks[1].priority.
		require
			enough_capacity:
				-- TODO: What's the relation between size of `tasks` and `n`?
				new_tasks.count <= n

			-- Assumption: all `priority` values in `new_tasks` are unqiue.
			-- You are not required to encode this assumption as a precondition for grading,
			-- but encouraged to try it for exercise.
		do
			-- TODO: Complete the implementation.
			create tasks.make (n) -- Initializing tasks with capacity 'n'
			-- Adding the tasks from 'new_tasks' to 'tasks'
			across 1 |..| new_tasks.count is i
			loop
				tasks.force (new_tasks[i].task, new_tasks[i].priority)
			end
			create pq.make (tasks.current_keys, n) -- Initializing priority queue with each task priorities
		ensure
			scheduler_size_set:
				-- Completed for you. Do not modify.
				count = tasks.count and count = pq.count
		end

feature -- Queries

	count: INTEGER
			-- Number of tasks added to the scheduler but not yet executed.

			-- No precondition or postcondition is needed.
		do
			-- TODO: Complete the postcondition.
			Result := tasks.count
		end

	is_empty: BOOLEAN
			-- Does the current scheduler have no tasks pending for execution?

			-- No precondition or postcondition is needed.
		do
			-- TODO: Complete the postcondition.
			Result := tasks.count = 0
		end

	priority_exists (priority: INTEGER): BOOLEAN
			-- Does the `priority` value exist for some existing task?

			-- No precondition or postcondition is needed.
		do
			-- TODO: Complete the postcondition.
			Result := tasks.has_key (priority)
		end

feature -- Commands

	add_task (new_task: TUPLE[task: TASK; priority: INTEGER])
			-- Add `new_task` into the scheduler, given that the priority value does not exist.

			-- No postcondition is needed.
		require
			non_existing_priority:
				-- Completed for you. Do not modify.
				not priority_exists (new_task.priority)
		do
			-- TODO: Complete the implementation.
			tasks.force (new_task.task, new_task.priority)
			pq.insert (new_task.priority)
		end

	next_task_to_execute: detachable TASK
			-- Next task with the highest priority to execute.
			-- The `detachable` modifier here means the return value might be void.
			-- This is because the inquiry to a hash table might fail if the key does not exist.
			-- See {HASH_TABLE}.item (`item` feature in the `HASH_TABLE` class).
			-- Also see the test.
		require
			non_empty_tasks:
				-- Completed for you. Do not modify.
				not is_empty
		do
			-- TODO: Complete the postcondition.
			Result := tasks.at (pq.maximum)
		end

	execute_next_task
			-- Execute the next task with the highest priority, if any, and
			-- remove it from the scheduler.
		require
			non_empty_tasks:
				-- Completed for you. Do not modify.
				not is_empty
		do
			-- TODO: Complete the implementation.
			tasks.remove (pq.maximum)
			pq.remove_maximum
		end

invariant

	consistent_counts:
		count = tasks.count and count = pq.count

	consistent_priorities_and_keys:
		-- TODO: Every task's priority value is an existing key of the underlying heap.
		across tasks.current_keys as i all pq.key_exists (i.item) end
end
