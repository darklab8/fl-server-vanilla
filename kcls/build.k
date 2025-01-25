import infra.kcls.models.github_workflow as gw
import infra.kcls.common.github as ghc
import infra.kcls.common.workflow
import infra.kcls.common.docker
import infra.kcls.actions.checkout_freelancer as cf

import yaml

_image_name = "darkwind8/fl-server-vanilla"
_freelancer_folder = r"${{ github.workspace }}/Freelancer"

build_wf: gw.Workflow =  {
    _filename = "build.yml"
    name = "Build"
    on = {
        push.tags: ghc.TagsSemverProduction
        workflow_dispatch: {}
    }
    jobs = {
        job = gw.Job{
            name = "build"
            steps = [
                ghc.CheckoutRepo
                ghc.GetVersionFromTag
                docker.DockerLogin{}
                cf.NewCheckoutFreelancer(cf.CheckoutArgs {
                    freelancer_mod = cf._mod_vanilla_full
                    freelancer_folder = _freelancer_folder
                })
                docker.Build(docker.BuildOpts {
                    push = True
                    image_name = _image_name
                    tag = ghc.GetVersionOutput
                })
            ]
        }
    }
}

_workflows = [
    build_wf
]

_run = [yaml.dump_to_file(a, ".github/workflows/${a._filename}", ignore_private=True, ignore_none=True) for a in _workflows]
