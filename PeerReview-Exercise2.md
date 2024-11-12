## Solution Assessment ##

## Peer-reviewer Information

* *name:* Xiuyuan Qi
* *email:* xyqi@ucdavis.edu

### Stage 1 ###

- [x] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

___
#### Justification ##### 
The camera is always centered on the Vessel. The drawn cross meets the requirements.

___
### Stage 2 ###

- [x] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

___
#### Justification ##### 
The camera is able to move on the z-x plane. The vessel will not move out of the frame. When the vessel is still, it can move at the same velocity as the camera. The frame is drawn correctly.

___
### Stage 3 ###

- [x] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

___
#### Justification ##### 
The vessel will not move out of the leash distance. Both follow_speed and catchup_speed perform correctly. The frame is drawn correctly.

___
### Stage 4 ###

- [ ] Perfect
- [x] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

___
#### Justification ##### 
The vessel will not move out of the leash distance. `lead_speed`, `catchup_delay_duration`, and `catchup_speed` meet the requirement individually. 

One minor flaw is that when the vessel moves at HYPER_SPEED, the camera should lead the vessel rather than center on the vessel.

___
### Stage 5 ###

- [ ] Perfect
- [ ] Great
- [ ] Good
- [x] Satisfactory
- [ ] Unsatisfactory

___
#### Justification ##### 
The vessel is able to move in the direction of target's movement when the vessel touchs the outer box. The frame is drawn correctly.

When the vessel is still and in between the inner box and outer box, the camera should not move. However, in the student's work, the camera will move until the vessel is inside of the inner box. Moreover, when the vessel is in between the inner box and outer box, the camera will not move in the direction of the vessel's movement. There is a little gap that make the vessel cannot touch both inner and outer box.
___
# Code Style #
Overall, the code style is consistent
#### Style Guide Infractions ####
All the code files should be put in the [camera_controllers](https://github.com/ensemble-ai/exercise-2-camera-control-jmmromero/tree/master/Obscura/scripts/camera_controllers) folder instead of [scenes](https://github.com/ensemble-ai/exercise-2-camera-control-jmmromero/tree/master/Obscura/scenes) folder
#### Style Guide Exemplars ####
1. correct use of snake_case to name [variable](https://github.com/ensemble-ai/exercise-2-camera-control-jmmromero/blob/5ad5941796146f11255683afa6182f639179db1f/Obscura/scenes/lerp_smoothing.gd#L5) and [function](https://github.com/ensemble-ai/exercise-2-camera-control-jmmromero/blob/5ad5941796146f11255683afa6182f639179db1f/Obscura/scenes/target_focus_lerp.gd#L50C6-L50C19)
2. Use PascalCase for every [class](https://github.com/ensemble-ai/exercise-2-camera-control-jmmromero/blob/5ad5941796146f11255683afa6182f639179db1f/Obscura/scenes/position_lock_camera.gd#L1).
___
# Best Practices #
In general, the code needs more comments. Some places need time to understand without comments.
#### Best Practices Infractions ####
[case 1](https://github.com/ensemble-ai/exercise-2-camera-control-jmmromero/blob/5ad5941796146f11255683afa6182f639179db1f/Obscura/scenes/target_focus_lerp.gd#L36-L44), [case 2](https://github.com/ensemble-ai/exercise-2-camera-control-jmmromero/blob/5ad5941796146f11255683afa6182f639179db1f/Obscura/scenes/lerp_smoothing.gd#L26-L34)  --Need comments for each if statement
#### Best Practices Exemplars ####
