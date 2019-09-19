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
				across 1 |..| a.count is i all a[i] > 0 end

			no_duplicates:
				-- TODO: No duplicates of keys are to be added to the heap.
				not (across a.lower |..| a.upper is i
					all
						across a.lower |..| a.upper is j some ((i /~ j) and (a[i] ~ a[j])) end
				end)
		local
			iindex:INTEGER
		do
			-- TODO: Initialize `array` such that it represents a binary tree
			-- satisfying the maximum heap property.
			-- Be sure to initialize `max_capacity` and `count` properly.
			-- Hint: Make use of the `heapify` command.
			-- Watch out for infinite loops!

			count := a.count --Number of filled keys
			max_capacity := n --Maximum capacity of array

			create array.make_filled (0, 1, max_capacity) --Creating an initial array of size 'max_capacity' with all values set to '0'
			array.subcopy (a, a.lower, a.upper, 1) --Copying elements of 'a' to 'array'

			--Creating max heap array by applying heapify
			from
				iindex := array.count // 2
			until
				iindex < array.lower
			loop
				heapify (iindex)
				iindex := iindex - 1
			end
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
		local
			largest, left_index, right_index, swap: INTEGER
		do
			-- TODO: Complete the implementation.
			-- Watch out for infinite loops!

			largest := i
			left_index := 2 * i
			right_index := (2 * i) + 1
			if
				has_left_child (i) and left_child_of (i) > array[largest]
			then
				largest := left_index
			end

			if
				has_right_child (i) and right_child_of (i) > array[largest]
			then
				largest := right_index
			end

			if
				largest /= i
			then
				swap := array[i]
				array[i] := array[largest]
				array[largest] := swap

				if
					is_valid_index (largest)
				then
					heapify (largest)
				end
			end

		ensure
			-- Heap property is maintained, see invariant `heap_property`.

			same_set_of_keys:
				-- TODO: old and new versions of `array` store the same set of integer keys.
				-- Hint: You may want to make use of the `is_permutation_of` query.
				is_permutation_of (array.subarray (i, count), old array.subarray (i, count))
		end

	insert (new_key: INTEGER)
			-- Add `new_key` into the heap, if it does not exist.
		require
			non_existing_key:
				-- Completed for you. Do not modify.
				not key_exists (new_key)
		local
			index, swap : INTEGER
		do
			-- TODO: Complete the implementation.
			-- Watch out for infinite loops!

			count := count + 1 --Increasing count
			array[count] := new_key  --Adding new key to the end of the array

			--Restoring the heap property using uphead
			from
				index := count
			until
				(index = 1) or (array[index] < array[index // 2])
			loop
				swap := array[index]
				array[index] := array[index // 2]
				array[index // 2] := swap
				index := index // 2
			end
		ensure
			-- Heap property is maintained, see invariant `heap_property`.

			size_incremented:
				-- TODO: Constraint on `count`
				count = old count + 1

			same_set_of_keys_except_the_new_key:
				-- TODO: Except `new_key` being just added,
				-- all other keys in the new `array` already exist in the old `array`.
				across 1 |..| array.count is i all (array[i] /~ new_key) implies (old array.deep_twin).has (array[i]) end
		end

	remove_maximum
			-- Remove the maximum key from heap, if it is not empty.

		require
			non_empty_heap:
				-- Completed for you. Do not modify.
				not is_empty
		local
			temp: ARRAY[INTEGER]
		do
			-- TODO: Complete the implementation.
			-- Hint: Make use of the `heapify` command.
			-- Watch out for infinite loops!
			temp := array.deep_twin
			array[1] := array[count]   --Swapping the root element with the last element
			array[count] := 0 --Setting the deleted key with a value of '0'
			count := count - 1 --Decreasing count

			heapify (1) --Restoring the heap property
		ensure
			-- Heap property is maintained, see invariant `heap_property`.

			size_decremented:
				-- TODO: Constraint on `count`
				count = old count - 1

			same_set_of_keys_except_the_removed_key:
				-- TODO: Except the key being just removed,
				-- all other keys in the old `array` still exist in the new `array`.
				across 1 |..| array.count is i all (old array.deep_twin).has(array[i]) end
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
		local
			mult1, mult2, sum1, sum2 : INTEGER
		do
			-- TODO: Complete the implementation.
			mult1 := 1
			mult2 := 1
			sum1 := 0
			sum2 := 0
			across a1.lower |..| a1.count is i
			loop
				mult1 := mult1 * array[i]
				sum1 := sum1 + array[i]
			end
			across a2.lower |..| a2.count is j
			loop
				mult2 := mult2 * array[j]
				sum2 := sum2 + array[j]
			end
			Result := mult1 = mult2 and sum1 = sum2
		end

feature -- Queries related to heaps

	is_empty: BOOLEAN
			-- Does the current heap store no integer keys?

			-- No precondition or postcondition is needed.
		do
			-- TODO: Complete the implementation.
			Result := count = 0
		end

	key_exists (a_key: INTEGER): BOOLEAN
			-- Does `a_key` exist in the current heap?

			-- No precondition is needed.
		do
			-- TODO: Complete the implementation.
			Result := across 1 |..| count is i some array[i] ~ a_key end
		ensure
			correct_result:
				-- TODO: Constraint on the return value `Result`
				across 1 |..| count is i all (array[i] = a_key) implies True end
		end

feature -- Queries related to binary trees

	is_valid_index (i: INTEGER): BOOLEAN
			-- Does index `i` denote an existing node in the current heap?

			-- No precondition or postcondition is needed.
		do
			-- TODO: Complete the implementation.
			Result := i >= 1 and i <= count
		end

	has_left_child (i: INTEGER): BOOLEAN
			-- Does index `i` store a node that has a left child node?

			-- No precondition or postcondition is needed.
		do
			-- TODO: Complete the implementation.
			Result := is_valid_index (i * 2)
		end

	has_right_child (i: INTEGER): BOOLEAN
			-- Does index `i` store a node that has a right child node?

			-- No precondition or postcondition is needed.
		do
			-- TODO: Complete the implementation.
			Result := is_valid_index ((i * 2) + 1)
		end

	has_parent (i: INTEGER): BOOLEAN
			-- Does index `i` store a node that has a parent node?

			-- No precondition or postcondition is needed.
		do
			-- TODO: Complete the implementation.
			Result := is_valid_index (i // 2)
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
			Result := array[i * 2]
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
			Result := array[(i * 2) + 1]
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
			Result := array[i // 2]
		end

	maximum: INTEGER
			-- Maximum of the current heap.
		require
			-- Precondition completed for you. Do not modify.
			non_empty:
				not is_empty
		do
			-- TODO: Complete the implementation.
			Result := array[1]
		ensure
			correct_result:
				-- TODO: The return value `Result` is the maximum integer key.
				 across 1 |..| count is i all array[i] <= Result end
		end

	is_a_max_heap (i: INTEGER): BOOLEAN
			-- Does the subtree rooted at node stored at index `i` satisfy the maximum heap property?
		require
			-- Precondition completed for you. Do not modify.
			valid_index:
				is_valid_index (i)
		do
			-- TODO: Complete the implementation.
			if
				has_left_child (i) and has_right_child (i)
			then
				Result := array[i] > left_child_of (i) and array[i] > right_child_of (i) and is_a_max_heap (2*i) and is_a_max_heap ((2*i)+1)
			elseif
				has_left_child (i) and not has_right_child (i)
			then
				Result := array[i] > left_child_of (i) and is_a_max_heap (2*i)
			else
				Result := True
			end
		ensure
			case_of_no_children:
				-- TODO: When index `i` denotes an external node, what happens to `Result`?
				(not has_left_child (i)) and (not has_right_child (i)) implies TRUE
			case_of_two_children:
				-- TODO: When index `i` denotes an internal node with both children, what happens to `Result`?
				(has_left_child (i) and has_right_child (i)) implies (Result = (array[i] > left_child_of (i) and array[i] > right_child_of (i)))
			case_of_one_child:
				-- TODO: When index `i` denotes an internal node with only one child, what happens to `Result`?
				(has_left_child (i) and not has_right_child (i)) implies (Result = (array[i] > left_child_of (i)))
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
