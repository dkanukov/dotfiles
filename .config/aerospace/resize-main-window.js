const { execSync } = require('child_process');
const { readFile, writeFile } = require('fs');

function update() {
	const CASE_ZERO = 'outer.top =        [{monitor.main = 12}, 0]';
	const CASE_NOT_ZERO = 'outer.top =        [{monitor.main = 32}, 12]';

	try {
		readFile('./aerospace.toml', (err, data) => {
			if (err) {
				console.log(err);
			}

			let cfg = data.toString();

			if (cfg.includes(CASE_ZERO)) {
				cfg = cfg.replace(CASE_ZERO, CASE_NOT_ZERO);
			} else if (cfg.includes(CASE_NOT_ZERO)) {
				cfg = cfg.replace(CASE_NOT_ZERO, CASE_ZERO);
			} else {
				console.log('Did not find string');
			}

			writeFile('./aerospace.toml', cfg, (err) => { err && console.log(err) });
		})
	} catch (err) {
		console.log(err);
	}

	execSync('aerospace reload-config', (error, stdout, stderr) => {
		if (error) {
			console.log(`error: ${error.message}`);
			return;
		}
		if (stderr) {
			console.log(`stderr: ${stderr}`);
			return;
		}
		console.log(`stdout: ${stdout}`);
	});
}

update()
