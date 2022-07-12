package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	test_structure "github.com/gruntwork-io/terratest/modules/test-structure"
	"github.com/stretchr/testify/assert"
)

func TestTerraformCreateGCPSQL(t *testing.T) {
	t.Parallel()

	t.Run("create mysql with public ip", func(t *testing.T) {
		t.Parallel()

		testDirectory := test_structure.CopyTerraformFolderToTemp(t, "..", "examples/create_redis_public_ip")

		// retryable errors in terraform testing.
		terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
			TerraformDir: testDirectory,
			Vars: map[string]interface{}{
				"google_region": "asia-southeast2",
			},
		})

		defer terraform.Destroy(t, terraformOptions)

		terraform.InitAndApply(t, terraformOptions)

		var output string

		output = terraform.Output(t, terraformOptions, "id")
		assert.NotEmpty(t, output)

		output = terraform.Output(t, terraformOptions, "second_id")
		assert.NotEmpty(t, output)

		output = terraform.Output(t, terraformOptions, "name")
		assert.NotEmpty(t, output)

		output = terraform.Output(t, terraformOptions, "host")
		assert.NotEmpty(t, output)

		output = terraform.Output(t, terraformOptions, "port")
		assert.NotEmpty(t, output)

	})

}
