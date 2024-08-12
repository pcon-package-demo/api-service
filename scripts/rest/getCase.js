const program = require('commander').program;
const axios = require('axios');
const execSync = require('child_process').execSync;

program
    .requiredOption('-o, --target-org <org-name>', 'The target org')
    .requiredOption('--id <id>', 'The case id');

program.parse();

const options = program.opts();
const org = options.targetOrg;
const id = options.id;

const cmd_org_display = `sf org display --json -o ${org}`;

const json_org_display = execSync(cmd_org_display);
const org_info = JSON.parse(json_org_display);

const access_token = org_info.result.accessToken;
const instance_url = org_info.result.instanceUrl;
const rest_uri = `/services/apexrest/v1/case/${id}`;
const path = `${instance_url}/${rest_uri}`;

const config = {
    headers: {
        Authorization: `Bearer ${access_token}`
    }
};

axios.get(path, config)
    .then(function (response) {
        console.log(response.data);
    })
    .catch(function (error) {
        console.error(error);
    });