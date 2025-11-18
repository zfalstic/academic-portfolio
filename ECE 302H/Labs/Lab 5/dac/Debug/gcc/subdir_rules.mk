################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Each subdirectory must supply rules for building sources it contributes
gcc/%.o: ../gcc/%.c $(GEN_OPTS) | $(GEN_FILES) $(GEN_MISC_FILES)
	@echo 'Building file: "$<"'
	@echo 'Invoking: GNU Compiler'
	"/Users/dawson/ti/gcc_arm_none_eabi_9_2_1/bin/arm-none-eabi-gcc-9.2.1" -c -mcpu=cortex-m0plus -march=armv6-m -mthumb -mfloat-abi=soft -D__MSPM0G3507__ -I"/Users/dawson/Documents/Classes/ECE 302H/Labs/Lab 5/dac" -I"/Users/dawson/Documents/Classes/ECE 302H/Labs/Lab 5/dac/Debug" -I"/Users/dawson/ti/mspm0_sdk_1_10_00_05/source/third_party/CMSIS/Core/Include" -I"/Users/dawson/ti/mspm0_sdk_1_10_00_05/source" -I"/Users/dawson/ti/gcc_arm_none_eabi_9_2_1/arm-none-eabi/include/newlib-nano" -I"/Users/dawson/ti/gcc_arm_none_eabi_9_2_1/arm-none-eabi/include" -O2 -ffunction-sections -fdata-sections -g -gdwarf-3 -gstrict-dwarf -Wall -MMD -MP -MF"gcc/$(basename $(<F)).d_raw" -MT"$(@)" -std=c99 $(GEN_OPTS__FLAG) -o"$@" "$<"
	@echo 'Finished building: "$<"'
	@echo ' '


