<script lang="ts">
	import mapfiles from './map-files.json';
	export let biome = 'overworld';
	export let layer = 'day';
	let mapImages = [];
	let grid = new Array(20).fill(null).map(() => new Array(20).fill(null));
	async function fetchMapImages(biome, layer) {
		grid = new Array(20).fill(null).map(() => new Array(20).fill(null));
		let biomeJson = mapfiles[biome];
		let layerJson = biomeJson[layer];
		// Parse filenames to get coordinates
		mapImages = layerJson.map((file) => {
			const [x, y] = file.replace('.png', '').split(',').map(Number);
			grid[x + grid[0].length / 2][y + grid.length / 2] = {
				x,
				y,
				src: `/map/${biome}/${layer}/${file}`
			};
		});
		console.log(grid);
	}
	$: fetchMapImages(biome, layer);
</script>

<div
	class="relative grid gap-0 row-span-full"
	style="grid-template-columns: repeat(auto-fill, 96px);"
>
	{#each grid as column, columnIndex}
		{#each Array(column.length) as _, rowIndex}
			{#if grid[columnIndex][rowIndex] != null}
				<div class="relative w-24 h-24" style="grid-row: {rowIndex}; grid-column: {columnIndex};">
					<button>
						<img
							src={grid[columnIndex][rowIndex].src}
							alt="Tile at (${columnIndex + 1}, ${rowIndex + 1})"
							class="w-full h-full object-cover"
						/>
					</button>
				</div>
			{:else}
				<div class="relative w-24 h-24" style="grid-row: {rowIndex}; grid-column: {columnIndex};">
					<div class="w-full h-full object-cover"></div>
				</div>
			{/if}
		{/each}
	{/each}
</div>
