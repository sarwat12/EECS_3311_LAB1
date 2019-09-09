note
	description: "A maximum heap implemented using an array."
	author: "Jackie and You"
	date: "$Date$"
	revision: "$Revision$"

class
	ARRAYED_HEAP

create
	-- Select command `make` to be the only constructor of the current class.
	make

feature -- Representation of an array-based heap

-- Do not modify any of these attributes.
-- Your implementation of heap features must make use of these attributes when appropriate.

	count: INTEGER
		-- number of keys stored in the heap
	max_capacity: INTEGER
		-- maximum number of keys that can be stored in the heap
	array: ARRAY[INTEGER]
		-- array representation of the heap

feature -- Constructor

	make (a: ARRAY[INTEGER]; n: INTEGER)
			-- Create a heap from an unsorted array `a`, with maximum capacity `n`.
			-- See all invariants which must be established by this constructor.
		require
			enough_capacity:
				-- TODO: What's the relation between size of `a` and `n`?
				a.count <= n

			all_positive:
				-- TODO: All keys to be added to the heap should be strictly positive.
				across 1 |..| a.count is i all a[i] >= 0 end

			no_duplicates:
				-- TODO: No duplicates of keys are to be added to the heap.
				True
		do
			-- TODO: Initialize `array` such that it represents a binary tree
			-- satisfying the maximum heap property.
			-- Be sure to initialize `max_capacity` and `count` properly.
			-- Hint: Make use of the `heapify` command.
			-- Watch out for infinite loops!

		ensure
			max_capacity_set:
				-- Completed for you. Do not modify.
				array.count = max_capacity and max_capacity = n
			heap_size_set:
				-- Completed for you. Do not modify.
				count = a.count
		end

feature -- Commands

	heapify (i: INTEGER)
			-- Starting from the node stored at index `i`,
			-- fix the heap property downwards, until an external node if necessary.
		require
			valid_index:
				-- Completed for you. Do not modify.
				is_valid_index (i)
		do
			-- TODO: Complete the implementation.
			-- Watch out for infinite loops!

		ensure
			-- Heap property is maintained, see invariant `heap_property`.

			same_set_of_keys:
				-- TODO: old and new versions of `array` store the same set of integer keys.
				-- Hint: You may want to make use of the `is_permutation_of` query.
				True
		end

	insert (new_key: INTEGER)
			-- Add `new_key` into the heap, if it does not exist.
		require
			non_existing_key:
				-- Completed for you. Do not modify.
				not key_exists (new_key)
		do
			-- TODO: Complete the implementation.
			-- Watch out for infinite loops!

		ensure
			-- Heap property is maintained, see invariant `heap_property`.

			size_incremented:
				-- TODO: Constraint on `count`
				True

			same_set_of_keys_except_the_new_key:
				-- TODO: Except `new_key` being just added,
				-- all other keys in the new `array` already exist in the old `array`.
				True
		end

	remove_maximum
			-- Remove the maximum key from heap, if it is not empty.
		require
			non_empty_heap:
				-- Completed for you. Do not modify.
				not is_empty
		do
			-- TODO: Complete the implementation.
			-- Hint: Make use of the `heapify` command.
			-- Watch out for infinite loops!

		ensure
			-- Heap property is maintained, see invariant `heap_property`.

			size_decremented:
				-- TODO: Constraint on `count`
				True

			same_set_of_keys_except_the_removed_key:
				-- TODO: Except the key being just removed,
				-- all other keys in the old `array` still exist in the new `array`.
				True
		end

feature -- Auxiliary queries for writing contracts

	is_permutation_of (a1, a2: like array): BOOLEAN
			-- Do arrays `a1` and `a2` store the same set of items,
			-- though they may be arranged in different orders?
			-- e.g., <<1, 2, 3, 4>> is a permutation of <<2, 1, 4, 3>>
			-- You can assume that both `a1` and `a2` are heap representation,
			-- and they thus contain no duplicates from indices 1 to `count`, whereas
			-- there are all zeros from indices `count` + 1 to `max_capacity`.

			-- No precondition or postcondition is needed.
		do
			-- TODO: Complete the implementation.

		end

feature -- Queries related to heaps

	is_empty: BOOLEAN
			-- Does the current heap store no integer keys?

			-- No precondition or postcondition is needed.
		do
			-- TODO: Complete the implementation.

		end

	key_exists (a_key: INTEGER): BOOLEAN
			-- Does `a_key` exist in the current heap?

			-- No precondition is needed.
		do
			-- TODO: Complete the implementation.

		ensure
			correct_result:
				-- TODO: Constraint on the return value `Result`
				True
		end

feature -- Queries related to binary trees

	is_valid_index (i: INTEGER): BOOLEAN
			-- Does index `i` denote an existing node in the current heap?

			-- No precondition or postcondition is needed.
		do
			-- TODO: Complete the implementation.

		end

	has_left_child (i: INTEGER): BOOLEAN
			-- Does index `i` store a node that has a left child node?

			-- No precondition or postcondition is needed.
		do
			-- TODO: Complete the implementation.

		end

	has_right_child (i: INTEGER): BOOLEAN
			-- Does index `i` store a node that has a right child node?

			-- No precondition or postcondition is needed.
		do
			-- TODO: Complete the implementation.

		end

	has_parent (i: INTEGER): BOOLEAN
			-- Does index `i` store a node that has a parent node?

			-- No precondition or postcondition is needed.
		do
			-- TODO: Complete the implementation.

		end

	left_child_of (i: INTEGER): INTEGER
			-- Left child node of what is stored at index `i`
			-- No postcondition is needed.
		require
			-- Precondition completed for you. Do not modify.
			valid_index:
				is_valid_index (i)
			left_child_exists:
				has_left_child (i)
		do
			-- TODO: Complete the implementation.

		end

	right_child_of (i: INTEGER): INTEGER
			-- Right child node of what is stored at index `i`
			-- No postcondition is needed.
		require
			-- Precondition completed for you. Do not modify.
			valid_index:
				is_valid_index (i)
			right_child_exists:
				has_right_child (i)
		do
			-- TODO: Complete the implementation.

		end

	parent_of (i: INTEGER): INTEGER
			-- Parent node of what is stored at index `i`
			-- No postcondition is needed.
		require
			-- Precondition completed for you. Do not modify.
			valid_index:
				is_valid_index (i)
			not_root:
				i /= 1
		do
			-- TODO: Complete the implementation.

		end

	maximum: INTEGER
			-- Maximum of the current heap.
		require
			-- Precondition completed for you. Do not modify.
			non_empty:
				not is_empty
		do
			-- TODO: Complete the implementation.

		ensure
			correct_result:
				-- TODO: The return value `Result` is the maximum integer key.
				True
		end

	is_a_max_heap (i: INTEGER): BOOLEAN
			-- Does the subtree rooted at node stored at index `i` satisfy the maximum heap property?
		require
			-- Precondition completed for you. Do not modify.
			valid_index:
				is_valid_index (i)
		do
			-- TODO: Complete the implementation.

		ensure
			case_of_no_children:
				-- TODO: When index `i` denotes an external node, what happens to `Result`?
				True
			case_of_two_children:
				-- TODO: When index `i` denotes an internal node with both children, what happens to `Result`?
				True
			case_of_one_child:
				-- TODO: When index `i` denotes an internal node with only one child, what happens to `Result`?
				True
		end

invariant
	-- All invariants are completed for you. Do not modify this section.

	implementation_indices:
		array.lower = 1 and array.upper = max_capacity

	no_heap_overflow:
		count <= max_capacity

	no_heap_underflow:
		count >= 0

	-- The tree is filled up from indices 1 to `count` in the array.
	-- Indices `count` + 1 to `n` should store zeros.
	-- all stored keys are strictly positive; all unused slots store zeros
	contents_of_heap:
		across 1 |..| count is i all array[i] > 0 end
		and
		across (count + 1) |..| max_capacity is i all array[i] = 0 end

	-- The maximum heap property.
	heap_property:
		is_a_max_heap (1)
end
