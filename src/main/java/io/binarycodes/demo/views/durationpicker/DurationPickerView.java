package io.binarycodes.demo.views.durationpicker;

import java.util.stream.Stream;

import io.binarycodes.vaadin.durationpicker.DurationPicker;
import io.binarycodes.vaadin.durationpicker.DurationUnit;

import com.vaadin.flow.component.Composite;
import com.vaadin.flow.component.button.Button;
import com.vaadin.flow.component.notification.Notification;
import com.vaadin.flow.component.orderedlayout.FlexComponent;
import com.vaadin.flow.component.orderedlayout.HorizontalLayout;
import com.vaadin.flow.component.orderedlayout.VerticalLayout;
import com.vaadin.flow.data.binder.Binder;
import com.vaadin.flow.router.Menu;
import com.vaadin.flow.router.PageTitle;
import com.vaadin.flow.router.Route;
import com.vaadin.flow.router.RouteAlias;

@PageTitle("Duration Picker")
@Route(value = "duration-picker")
@RouteAlias(value = "")
@Menu(order = 0)
public class DurationPickerView extends Composite<VerticalLayout> {

    public DurationPickerView() {
        var fieldLabel = "Duration";
        var closeButtonLabel = "Ok";

        var readOnlyPicker = new DurationPicker.Builder().hours(2).minutes(10).seconds(30)
                .customLabels("D", "H", "M", "S").build();
        readOnlyPicker.setReadOnly(true);

        var disabledPicker = new DurationPicker.Builder().hours(2).minutes(10).seconds(30)
                .customLabels("D", "H", "M", "S").build();
        disabledPicker.setEnabled(false);

        Stream.of(new DurationPicker(fieldLabel, closeButtonLabel),
                        new DurationPicker(fieldLabel, closeButtonLabel, DurationUnit.HOURS, DurationUnit.MINUTES),
                        new DurationPicker.Builder().hours().minutes().seconds().fieldLabel("How long ?").closePopupLabel("Done").build(),
                        new DurationPicker.Builder().hours(2).minutes(10).seconds(30).customLabels("D", "H", "M", "S").build(),
                        readOnlyPicker,
                        disabledPicker)
                .forEach(this::commonSetup);
    }

    private void commonSetup(DurationPicker durationPicker) {
        var data = new DataBean();

        var binder = new Binder<DataBean>();
        binder.forField(durationPicker).asRequired().bind(DataBean::getDuration, DataBean::setDuration);
        binder.setBean(data);

        var button = new Button("Click me", event -> {
            if (binder.validate().isOk()) {
                Notification.show(data.getDuration().toString());
            }
        });

        var layout = new HorizontalLayout(durationPicker, button);
        layout.setAlignItems(FlexComponent.Alignment.BASELINE);
        getContent().add(layout);
    }
}
