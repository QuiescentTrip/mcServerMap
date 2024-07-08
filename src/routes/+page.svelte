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

  const handleMouseDown = (event) => {
    isDragging = true;
    startX = event.clientX;
    startY = event.clientY;
    event.preventDefault();
  };

  const handleMouseMove = (event) => {
    if (isDragging) {
      currentX = event.clientX;
      currentY = event.clientY;
      offsetX = currentX - startX;
      offsetY = currentY - startY;
      console.log(`Dragging: (${offsetX}, ${offsetY})`);
    }
  };

  const handleMouseUp = () => {
    isDragging = false;
  };
  let scrollY = 0;

const handleScroll = (event) => {
console.log(event)
  scrollY = window.scrollY;
  console.log(`Scroll position: ${scrollY}`);
};
	onMount(() => {
    window.addEventListener('mousemove', handleMouseMove);
    window.addEventListener('mouseup', handleMouseUp);
    window.addEventListener('scroll', handleScroll);
	})
  
</script>
<!-- YOU CAN DELETE EVERYTHING IN THIS PAGE -->

<div class="w-screen h-screen mx-auto flex justify-center items-center overflow-hidden" on:mousedown={handleMouseDown}>
	<div class="fixed scale-[3]" style="left: {currentX}px; top: {currentY}px">
	<Map />
</div>
</div>
