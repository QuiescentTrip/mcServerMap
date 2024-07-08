<script lang="ts">
	import Map from "../lib/map/map.svelte";
	import { onMount } from 'svelte';

	let isDragging = false;
	let startX = 0;
	let startY = 0;
	let currentX = 0;
	let currentY = 0;
	let offsetX = 0;
	let offsetY = 0;
	let zoom = 10;
	let x = 0;
	let y = 0;
	let initX = 0;
	let initY = 0;

	const handleMouseDown = (event) => {
		isDragging = true;
		startX = event.clientX;
		startY = event.clientY;
		initX = x;
		initY = y;
		event.preventDefault();
	};

	const handleMouseMove = (event) => {
		if (isDragging) {
			currentX = event.clientX;
			currentY = event.clientY;
			offsetX = currentX - startX;
			offsetY = currentY - startY;
			x = initX + offsetX;
			y = initY + offsetY;
		}
	};

	const handleMouseUp = () => {
		isDragging = false;
	};

	const handleScroll = (event) => {
		if (event.deltaY < 0) {
			zoom *= 1.1;
		} else {
			zoom /= 1.1;
		}
	};

	onMount(() => {
		x = window.innerWidth / 2 + 300;
		y = window.innerHeight / 2;

		window.addEventListener('mousemove', handleMouseMove);
		window.addEventListener('mouseup', handleMouseUp);
		window.addEventListener('wheel', handleScroll);
	});
</script>

<!-- YOU CAN DELETE EVERYTHING IN THIS PAGE -->

<div class="w-screen h-screen mx-auto flex justify-center items-center overflow-hidden" on:mousedown={handleMouseDown}>
	<div class="fixed" style="transform: scale({zoom}); left: {x}px; top: {y}px;">
		<Map />
	</div>
</div>
