# 2025-09-15T18:24:21.063989
import vitis

client = vitis.create_client()
client.set_workspace(path="soc2024_2")

platform = client.get_component(name="platform_btn_fnd")
status = platform.build()

comp = client.get_component(name="app_btn_fnd")
comp.build()

platform = client.get_component(name="platform_stopwatch_intc")
status = platform.build()

comp = client.get_component(name="app_stopwatch_intc")
comp.build()

platform = client.get_component(name="platform_stopwatch_min")
status = platform.build()

comp = client.get_component(name="app_stopwatch_min")
comp.build()

platform = client.get_component(name="platform_stopwatch_intc")
status = platform.build()

comp = client.get_component(name="app_stopwatch_intc")
comp.build()

status = platform.build()

comp.build()

vitis.dispose()

