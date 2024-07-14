<script lang="ts">
	import Map from '$lib/map/map.svelte';
	import { onMount } from 'svelte';
	import mapdata from '$lib/map/map-files.json';

	let currentBiome = 'overworld';
	let currentLayer = 'day';

	const biomes = Object.keys(mapdata);
	let layers: string | undefined = Object.keys(mapdata[currentBiome]);
	$: layers = Object.keys(mapdata[currentBiome]).filter(
		(key) => mapdata[currentBiome][key].length > 0
	);

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

	const handleTouchStart = (event) => {
		if (event.touches.length === 1) {
			isDragging = true;
			startX = event.touches[0].clientX;
			startY = event.touches[0].clientY;
			initX = x;
			initY = y;
		}
		event.preventDefault();
	};

	const handleTouchMove = (event) => {
		if (isDragging && event.touches.length === 1) {
			currentX = event.touches[0].clientX;
			currentY = event.touches[0].clientY;
			offsetX = currentX - startX;
			offsetY = currentY - startY;
			x = initX + offsetX;
			y = initY + offsetY;
		}
	};

	const handleTouchEnd = () => {
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
		window.addEventListener('touchmove', handleTouchMove);
		window.addEventListener('touchend', handleTouchEnd);
	});

	const handleMouseDownTouchStart = (event) => {
		if (event.type === 'mousedown') {
			handleMouseDown(event);
		} else if (event.type === 'touchstart') {
			handleTouchStart(event);
		}
	};
	function changeBiome(biome) {
		zoom = 10;
		x = 0;
		y = 0;
		currentBiome = biome;
		if (currentBiome == 'the_nether') {
			currentLayer = 'biome';
		} else {
			currentLayer = 'day';
		}
	}
	$: console.log(currentBiome);
</script>

<!-- YOU CAN DELETE EVERYTHING IN THIS PAGE -->

<!-- svelte-ignore a11y-no-static-element-interactions -->
<div
	class="w-screen h-screen mx-auto flex justify-center items-center overflow-hidden"
	on:mousedown={handleMouseDownTouchStart}
	on:touchstart={handleMouseDownTouchStart}
>
	<div class="fixed" style="transform: scale({zoom}); left: {x}px; top: {y}px;">
		<Map biome={currentBiome} layer={currentLayer} />
	</div>
	<div
		class="z-50 rounded-xl fixed bottom-20 scale-[2] flex flex-row justify-center items-center text-center bg-gray-800 text-white p-4 space-x-4"
	>
		{#each biomes as biome}
			<button on:click={() => changeBiome(biome)} class="px-4 py-2 hover:bg-gray-700 rounded"
				>{biome}</button
			>
		{/each}
	</div>
	<div
		class="z-50 rounded-xl fixed left-8 flex flex-col bg-gray-800 text-white p-4 gap-3 my-auto max-h-full"
	>
		{#each layers as layer}
			<button
				on:click={() => (currentLayer = layer)}
				class="text-xl p-4 px-6 hover:bg-gray-700 rounded">{layer}</button
			>
		{/each}
	</div>
</div>
