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

  <style>
    .map-container {
      position: relative;
      display: grid;
      grid-template-columns: repeat(auto-fill, 100px); /* Adjust tile size here */
      gap: 0;
    }
    .map-tile {
      position: relative;
      width: 100px; /* Adjust tile size here */
      height: 100px; /* Adjust tile size here */
    }
    .map-tile img {
      width: 100%;
      height: 100%;
      object-fit: cover;
    }
  </style>
  
  <div class="map-container">
    {#each mapImages as { x, y, src }}
      <div class="map-tile" style="grid-row: {y - 1}; grid-column: {x + 1}" on:click={() => handleClick(x, y)}>
        <img src={src} alt={`Tile at (${x}, ${y})`} />
      </div>
    {/each}
  </div>
  