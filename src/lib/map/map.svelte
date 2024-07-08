<script>
  import { onMount } from 'svelte';

  let mapImages = [];

  onMount(async () => {
      // Fetch image filenames from the server
      const response = await fetch('/map-files.json');
      const files = await response.json();

      // Parse filenames to get coordinates
      mapImages = files.map(file => {
          const [x, y] = file.replace('.png', '').split(',').map(Number);
          return { x, y, src: `/map/${file}` };
      });
  });

  function handleClick(x, y) {
      alert(`You clicked on the tile at coordinates: (${x}, ${y})`);
  }
</script>

<div class="relative grid gap-0 row-span-full" style="grid-template-columns: repeat(auto-fill);">
  {#each mapImages as { x, y, src }}
      <div class="relative w-24 h-24" style="grid-row: {y - 1}; grid-column: {x + 1}">
          <img src={src} alt={`Tile at (${x}, ${y})`} class="w-full h-full object-cover" />
      </div>
  {/each}
</div>