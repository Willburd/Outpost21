import { capitalize } from 'common/string';

import { useBackend } from '../backend';
import {
  Box,
  Button,
  ByondUi,
  ColorBox,
  Flex,
  LabeledList,
  Section,
} from '../components';
import { Window } from '../layouts';

export const BodyDesigner = (props) => {
  const { act, data } = useBackend();

  const { menu, disk, diskStored, activeBodyRecord, temp } = data;

  let body = MenuToTemplate[menu];

  return (
    <Window width={750} height={850}>
      <Window.Content>
        <Box>
          <Button
            icon="save"
            content="Save To Disk"
            onClick={() => act('savetodisk')}
            disabled={!disk || !activeBodyRecord}
          />
          <Button
            icon="save"
            content="Load From Disk"
            onClick={() => act('loadfromdisk')}
            disabled={!disk || !diskStored}
          />
          <Button icon="eject" content="Eject" onClick={() => act('ejectdisk')} disabled={!disk} />
        </Box>
        {body}
      </Window.Content>
    </Window>
  );
};

const BodyDesignerMain = (props) => {
  const { act, data } = useBackend();
  return (
    <Section title="Database Functions">
      <Button
        icon="eye"
        content="View Individual Body Records"
        onClick={() => act('menu', { menu: 'Body Records' })}
      />
      <Button
        icon="eye"
        content="View Stock Body Records"
        onClick={() => act('menu', { menu: 'Stock Records' })}
      />
    </Section>
  );
};

const BodyDesignerBodyRecords = (props) => {
  const { act, data } = useBackend();
  const { bodyrecords } = data;
  return (
    <Section
      title="Body Records"
      buttons={
        <Button
          icon="arrow-left"
          content="Back"
          onClick={() => act('menu', { menu: 'Main' })}
        />
      }
    >
      {bodyrecords
        ? bodyrecords.map((record) => (
            <Button
              icon="eye"
              key={record.name}
              content={record.name}
              onClick={() => act('view_brec', { view_brec: record.recref })}
            />
          ))
        : ''}
    </Section>
  );
};

const BodyDesignerStockRecords = (props) => {
  const { act, data } = useBackend();
  const { stock_bodyrecords } = data;
  return (
    <Section
      title="Stock Records"
      buttons={
        <Button
          icon="arrow-left"
          content="Back"
          onClick={() => act('menu', { menu: 'Main' })}
        />
      }
    >
      {stock_bodyrecords.map((record) => (
        <Button
          icon="eye"
          key={record}
          content={record}
          onClick={() => act('view_stock_brec', { view_stock_brec: record })}
        />
      ))}
    </Section>
  );
};

const BodyDesignerSpecificRecord = (props) => {
  const { act, data } = useBackend();
  const { activeBodyRecord, mapRef } = data;
  return activeBodyRecord ? (
    <Section
      title="Specific Record"
      buttons={<Button icon="arrow-left" content="Back" onClick={() => act('menu', { menu: 'Main' })} />}>
      <Flex direction="column">
        <Flex.Item basis="175px">
          <Flex.Item>
            <ByondUi
              style={{
                width: '100%',
                height: '165px',
              }}
              params={{
                id: mapRef,
                type: 'map',
              }}
            />
          </Flex.Item>
        </Flex.Item>
        <Flex.Item basis="300px">
          <Flex direction="row">
            <Flex.Item basis="48%">
              <Section title="Data">
                <LabeledList>
                  <LabeledList.Item label="Name">
                    <Button
                      icon="pen"
                      content={activeBodyRecord.real_name}
                      disabled={activeBodyRecord.locked === 1}
                      onClick={() =>
                        act('href_conversion', {
                          target_href: 'rename',
                          target_value: 1,
                        })
                      }
                    />
                  </LabeledList.Item>
                  <LabeledList.Item label="Species">{activeBodyRecord.speciesname}</LabeledList.Item>
                  <LabeledList.Item label="Custom Species Name">
                    <Button
                      icon="pen"
                      content={activeBodyRecord.speciescustom}
                      disabled={activeBodyRecord.locked === 1}
                      onClick={() =>
                        act('href_conversion', {
                          target_href: 'custom_species',
                          target_value: 1,
                        })
                      }
                    />
                  </LabeledList.Item>
                  <LabeledList.Item label="Custom Species Icon">
                    <Button
                      icon="pen"
                      content={activeBodyRecord.speciesicon}
                      disabled={!activeBodyRecord.canusecustomicon || activeBodyRecord.locked === 1}
                      onClick={() =>
                        act('href_conversion', {
                          target_href: 'custom_base',
                          target_value: 1,
                        })
                      }
                    />
                  </LabeledList.Item>
                  <LabeledList.Item label="Bio. Sex">
                    <Button
                      icon="pen"
                      content={capitalize(activeBodyRecord.gender)}
                      disabled={activeBodyRecord.locked === 1}
                      onClick={() =>
                        act('href_conversion', {
                          target_href: 'bio_gender',
                          target_value: 1,
                        })
                      }
                    />
                  </LabeledList.Item>
                  <LabeledList.Item label="Synthetic">{activeBodyRecord.synthetic}</LabeledList.Item>
                  <LabeledList.Item label="Mind Compat">
                    {activeBodyRecord.locked ? 'Low' : 'High'}
                    <Button
                      ml={1}
                      icon="eye"
                      content="View OOC Notes"
                      disabled={!activeBodyRecord.booc}
                      onClick={() => act('boocnotes')}
                    />
                  </LabeledList.Item>
                  <LabeledList.Item label="Weight">
                    <Button
                      icon="pen"
                      content={activeBodyRecord.weight}
                      disabled={activeBodyRecord.locked === 1}
                      onClick={() =>
                        act('href_conversion', {
                          target_href: 'weight',
                          target_value: 1,
                        })
                      }
                    />
                  </LabeledList.Item>
                  <LabeledList.Item label="Blood">
                    <Button
                      icon="pen"
                      content={capitalize(activeBodyRecord.blood_type)}
                      disabled={activeBodyRecord.locked === 1}
                      onClick={() =>
                        act('href_conversion', {
                          target_href: 'blood_type',
                          target_value: 1,
                        })
                      }
                    />
                    <Button
                      icon="pen"
                      content="Color"
                      backgroundColor={activeBodyRecord.blood_color}
                      disabled={activeBodyRecord.locked === 1}
                      onClick={() =>
                        act('href_conversion', {
                          target_href: 'blood_color',
                          target_value: 1,
                        })
                      }
                    />
                  </LabeledList.Item>
                </LabeledList>
              </Section>
              <Section title="Unique Identifiers">
                <LabeledList>
                  <LabeledList.Item label="Scale">
                    <Button
                      icon="pen"
                      content={activeBodyRecord.scale}
                      disabled={activeBodyRecord.locked === 1}
                      onClick={() =>
                        act('href_conversion', {
                          target_href: 'size_multiplier',
                          target_value: 1,
                        })
                      }
                    />
                  </LabeledList.Item>
                  {Object.keys(activeBodyRecord.styles).map((key) => {
                    const style = activeBodyRecord.styles[key];
                    return (
                      <LabeledList.Item key={key} label={key}>
                        {style.styleHref ? (
                          <Button
                            icon="pen"
                            content={style.style}
                            disabled={activeBodyRecord.locked === 1}
                            onClick={() =>
                              act('href_conversion', {
                                target_href: style.styleHref,
                                target_value: 1,
                              })
                            }
                          />
                        ) : null}
                        {style.colorHref ? (
                          <Box>
                            <Button
                              icon="pen"
                              content={style.color}
                              disabled={activeBodyRecord.locked === 1}
                              onClick={() =>
                                act('href_conversion', {
                                  target_href: style.colorHref,
                                  target_value: 1,
                                })
                              }
                            />
                            <ColorBox
                              verticalAlign="top"
                              width="32px"
                              height="20px"
                              color={style.color}
                              style={{
                                border: '1px solid #fff',
                              }}
                            />
                          </Box>
                        ) : null}
                        {style.colorHref2 ? (
                          <Box>
                            <Button
                              icon="pen"
                              content={style.color2}
                              disabled={activeBodyRecord.locked === 1}
                              onClick={() =>
                                act('href_conversion', {
                                  target_href: style.colorHref2,
                                  target_value: 1,
                                })
                              }
                            />
                            <ColorBox
                              verticalAlign="top"
                              width="32px"
                              height="20px"
                              color={style.color2}
                              style={{
                                border: '1px solid #fff',
                              }}
                            />
                          </Box>
                        ) : null}
                        {style.colorHref3 ? (
                          <Box>
                            <Button
                              icon="pen"
                              content={style.color3}
                              disabled={activeBodyRecord.locked === 1}
                              onClick={() =>
                                act('href_conversion', {
                                  target_href: style.colorHref3,
                                  target_value: 1,
                                })
                              }
                            />
                            <ColorBox
                              verticalAlign="top"
                              width="32px"
                              height="20px"
                              color={style.color3}
                              disabled={activeBodyRecord.locked === 1}
                              style={{
                                border: '1px solid #fff',
                              }}
                            />
                          </Box>
                        ) : null}
                      </LabeledList.Item>
                    );
                  })}
                </LabeledList>
              </Section>
            </Flex.Item>
            <Flex.Item basis="50%">
              <Section title="Customize">
                <LabeledList>
                  <LabeledList.Item label="General">
                    <Button
                      icon="pen"
                      content="Edit"
                      disabled={activeBodyRecord.locked === 1}
                      onClick={() =>
                        act('href_conversion', {
                          target_href: 'flavor_text',
                          target_value: 'general',
                        })
                      }
                    />
                    <br />
                    {activeBodyRecord.flavors['general']}
                  </LabeledList.Item>
                  <LabeledList.Item label="Head">
                    <Button
                      icon="pen"
                      content="Edit"
                      disabled={activeBodyRecord.locked === 1}
                      onClick={() =>
                        act('href_conversion', {
                          target_href: 'flavor_text',
                          target_value: 'head',
                        })
                      }
                    />
                    <br />
                    {activeBodyRecord.flavors['head']}
                  </LabeledList.Item>
                  <LabeledList.Item label="Face">
                    <Button
                      icon="pen"
                      content="Edit"
                      disabled={activeBodyRecord.locked === 1}
                      onClick={() =>
                        act('href_conversion', {
                          target_href: 'flavor_text',
                          target_value: 'face',
                        })
                      }
                    />
                    <br />
                    {activeBodyRecord.flavors['face']}
                  </LabeledList.Item>
                  <LabeledList.Item label="Eyes">
                    <Button
                      icon="pen"
                      content="Edit"
                      disabled={activeBodyRecord.locked === 1}
                      onClick={() =>
                        act('href_conversion', {
                          target_href: 'flavor_text',
                          target_value: 'eyes',
                        })
                      }
                    />
                    <br />
                    {activeBodyRecord.flavors['eyes']}
                  </LabeledList.Item>
                  <LabeledList.Item label="Body">
                    <Button
                      icon="pen"
                      content="Edit"
                      disabled={activeBodyRecord.locked === 1}
                      onClick={() =>
                        act('href_conversion', {
                          target_href: 'flavor_text',
                          target_value: 'torso',
                        })
                      }
                    />
                    <br />
                    {activeBodyRecord.flavors['torso']}
                  </LabeledList.Item>
                  <LabeledList.Item label="Arms">
                    <Button
                      icon="pen"
                      content="Edit"
                      disabled={activeBodyRecord.locked === 1}
                      onClick={() =>
                        act('href_conversion', {
                          target_href: 'flavor_text',
                          target_value: 'arms',
                        })
                      }
                    />
                    <br />
                    {activeBodyRecord.flavors['arms']}
                  </LabeledList.Item>
                  <LabeledList.Item label="Hands">
                    <Button
                      icon="pen"
                      content="Edit"
                      disabled={activeBodyRecord.locked === 1}
                      onClick={() =>
                        act('href_conversion', {
                          target_href: 'flavor_text',
                          target_value: 'hands',
                        })
                      }
                    />
                    <br />
                    {activeBodyRecord.flavors['hands']}
                  </LabeledList.Item>
                  <LabeledList.Item label="Legs">
                    <Button
                      icon="pen"
                      content="Edit"
                      disabled={activeBodyRecord.locked === 1}
                      onClick={() =>
                        act('href_conversion', {
                          target_href: 'flavor_text',
                          target_value: 'legs',
                        })
                      }
                    />
                    <br />
                    {activeBodyRecord.flavors['legs']}
                  </LabeledList.Item>
                  <LabeledList.Item label="Feet">
                    <Button
                      icon="pen"
                      content="Edit"
                      disabled={activeBodyRecord.locked === 1}
                      onClick={() =>
                        act('href_conversion', {
                          target_href: 'flavor_text',
                          target_value: 'feet',
                        })
                      }
                    />
                    <br />
                    {activeBodyRecord.flavors['feet']}
                  </LabeledList.Item>
                  <LabeledList.Item label="Body Markings">
                    <Button
                      icon="plus"
                      content="Add Marking"
                      disabled={activeBodyRecord.locked === 1}
                      onClick={() =>
                        act('href_conversion', {
                          target_href: 'marking_style',
                          target_value: 1,
                        })
                      }
                    />
                    <Flex wrap="wrap" justify="center" align="center">
                      {Object.keys(activeBodyRecord.markings).map((key) => {
                        const marking = activeBodyRecord.markings[key];
                        return (
                          <Flex.Item basis="100%" key={key}>
                            <Flex>
                              <Flex.Item>
                                <Button
                                  mr={0.2}
                                  fluid
                                  icon="times"
                                  color="red"
                                  disabled={activeBodyRecord.locked === 1}
                                  onClick={() =>
                                    act('href_conversion', {
                                      target_href: 'marking_remove',
                                      target_value: key,
                                    })
                                  }
                                />
                              </Flex.Item>
                              <Flex.Item>
                                <Button
                                  mr={0.2}
                                  fluid
                                  icon="sort-up"
                                  color="blue"
                                  disabled={activeBodyRecord.locked === 1}
                                  onClick={() =>
                                    act('href_conversion', {
                                      target_href: 'marking_up',
                                      target_value: key,
                                    })
                                  }
                                />
                              </Flex.Item>
                              <Flex.Item>
                                <Button
                                  mr={0.2}
                                  fluid
                                  icon="sort-down"
                                  color="blue"
                                  disabled={activeBodyRecord.locked === 1}
                                  onClick={() =>
                                    act('href_conversion', {
                                      target_href: 'marking_down',
                                      target_value: key,
                                    })
                                  }
                                />
                              </Flex.Item>
                              <Flex.Item grow={1}>
                                <Button
                                  fluid
                                  backgroundColor={marking}
                                  content={key}
                                  disabled={activeBodyRecord.locked === 1}
                                  onClick={() =>
                                    act('href_conversion', {
                                      target_href: 'marking_color',
                                      target_value: key,
                                    })
                                  }
                                />
                              </Flex.Item>
                            </Flex>
                          </Flex.Item>
                        );
                      })}
                    </Flex>
                  </LabeledList.Item>
                </LabeledList>
              </Section>
            </Flex.Item>
          </Flex>
        </Flex.Item>
      </Flex>
    </Section>
  ) : (
    <Box color="bad">ERROR: Record Not Found!</Box>
  );
};

const BodyDesignerOOCNotes = (props) => {
  const { act, data } = useBackend();
  const { activeBodyRecord } = data;
  return (
    <Section
      title="Body OOC Notes (This is OOC!)"
      height="100%"
      scrollable
      buttons={
        <Button
          icon="arrow-left"
          content="Back"
          onClick={() => act('menu', { menu: 'Specific Record' })}
        />
      }
      style={{ 'word-break': 'break-all' }}
    >
      {(activeBodyRecord && activeBodyRecord.booc) ||
        'ERROR: Body record not found!'}
    </Section>
  );
};

const MenuToTemplate = {
  Main: <BodyDesignerMain />,
  'Body Records': <BodyDesignerBodyRecords />,
  'Stock Records': <BodyDesignerStockRecords />,
  'Specific Record': <BodyDesignerSpecificRecord />,
  'OOC Notes': <BodyDesignerOOCNotes />,
};
